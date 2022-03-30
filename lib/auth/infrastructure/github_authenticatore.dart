import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';
import 'package:repo_viewer/auth/domain/auth_failure.dart';
import 'package:repo_viewer/auth/infrastructure/keys.dart';
import 'package:repo_viewer/core/infrastructure/dio_extensions.dart';
import 'package:repo_viewer/core/shared/encoders.dart';
import 'credential_storage/credential_storage.dart';

class GithubOAuthHttpClient extends http.BaseClient {
  /// By default, the Github response takes the following form:
  ///
  /// `access_token=[AccessToken]&token_type=bearer`.
  ///
  /// We can receive the content in `Json` format by modifying the `Accept` header
  GithubOAuthHttpClient();
  final httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return httpClient.send(request);
  }
}

class Github {
  // Injecting dependencies.
  final CredentialStorage _credentialStorage;
  final Dio _dio;

  Github(this._credentialStorage, this._dio);

  static const scopes = ['read:user', 'repo'];

  // The API end point in which will revoke the access token.
  static final revocationEndPoint =
      Uri.parse('https://api.github.com/applications/$clientId/token');

  static final authorizationEndPoint =
      Uri.parse('https://github.com/login/oauth/authorize');

  // The API end point to get a valid access token.
  static final tokenEndPoint =
      Uri.parse('https://github.com/login/oauth/access_token');

  // The Url that will be directed to which will hold code that could be exchange for an access token.
  static final redirectedUrl = Uri.parse('http://localhost:3000/callback');

  /// Return and Refresh user's credential which was stored in previose session.
  /// Can throw [PlatformException].
  Future<Credentials?> getSignedInCredentials() async {
    try {
      // Reading storage.
      final storedCredentials = await _credentialStorage.read();

      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final authOrFailure = await refresh(storedCredentials);
          authOrFailure.fold(
            (l) => null,
            (r) => r,
          );
        } else {
          return storedCredentials;
        }
      } else {
        return null;
      }
    } on PlatformException {
      return null;
    }
  }

  /// Returns an [Either] type of new set of refreshed [Credentials] or [AuthFailure].
  Future<Either<AuthFailure, Credentials>> refresh(
    Credentials expireCred,
  ) async {
    try {
      final refreshedCredentials = await expireCred.refresh(
        identifier: clientId,
        secret: clientSecret,
        httpClient: GithubOAuthHttpClient(),
      );
      await _credentialStorage.save(refreshedCredentials);

      return right(refreshedCredentials);
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on FormatException {
      return left(const AuthFailure.storage());
      // [CredentialStorage] can throw [PlatformException].
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  /// Checks user's status.
  ///
  /// Returns `true` if signed-in.
  Future<bool> get isSignedIn =>
      getSignedInCredentials().then((credentials) => credentials != null);

  /// Creates a new grant.
  AuthorizationCodeGrant createGrand() {
    return AuthorizationCodeGrant(
      clientId,
      authorizationEndPoint,
      tokenEndPoint,
      secret: clientSecret,
      httpClient: GithubOAuthHttpClient(),
    );
  }

  /// Returns the URL to which the resource owner should be redirected to
  /// authorize this client.
  ///
  /// The resource owner will then be redirected to [redirect], which should
  /// point to a server controlled by the client. This redirect will have
  /// additional query parameters that should be passed to
  /// [handleAuthorizationResponse].
  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) {
    return grant.getAuthorizationUrl(redirectedUrl, scopes: scopes);
  }

  /// Processes the query parameters added to a redirect from the authorization
  /// server.
  ///
  /// Stores user's credentials in local storage.
  ///
  /// Returns an [Either] type of [AuthFailure] or [void].
  Future<Either<AuthFailure, Unit>> handelAuthorizationResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      final httpClient = await grant.handleAuthorizationResponse(queryParams);

      await _credentialStorage.save(httpClient.credentials);

      return right(unit);
    } on FormatException {
      return left(const AuthFailure.server());
    } on AuthorizationException catch (e) {
      return left(AuthFailure.server('${e.error}: ${e.description}'));
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  /// Preform a `DELETE` request to revoke user's access token and delete them from local storage.
  ///
  /// Note that access token will `NOT` be revoked if there's no internet connection.
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final accessToken = await _credentialStorage
          .read()
          .then((credentials) => credentials?.accessToken);

      final usernameAndPassword =
          stringToBase64.encode('$clientId:$clientSecret');
      try {
        await _dio.deleteUri(
          revocationEndPoint,
          data: {
            'access_token': accessToken,
          },
          options: Options(
            headers: {
              'Authorization': 'basic $usernameAndPassword',
            },
          ),
        );
      } on DioError catch (e) {
        if (e.isNoConnectionError) {
          //token did not revoke.
        } else {
          rethrow;
        }
      }

      return clearCredential();
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }

  /// Clears credentials from local storage.
  Future<Either<AuthFailure, Unit>> clearCredential() async {
    try {
      await _credentialStorage.clear();
      return right(unit);
    } on PlatformException {
      return left(const AuthFailure.storage());
    }
  }
}
