import 'package:dio/dio.dart';

import '../application/auth_notifier.dart';
import 'github_authenticatore.dart';

class OAuth2Interceptore extends Interceptor {
  final Github _authenticator;
  final AuthNotifier _notifier;
  final Dio _dio;

  OAuth2Interceptore(this._authenticator, this._notifier, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = await _authenticator.getSignedInCredentials();
    //used cascade to make the return type Request instead of void, cause
    //addAll return void, but headers return Request.
    final modifiedOptions = options
      ..headers.addAll(
        credentials == null
            ? {}
            : {'authorization': 'bearer ${credentials.accessToken}'},
      );
    handler.next(modifiedOptions);
  }

  //incase of expired accessToken, we want to sign out.
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // Unauthorized 401.
    // Token has expired and can't be refreshed.
    if (err.response != null && err.response?.statusCode == 401) {
      //final credentials = await _authenticator.getSignedInCredentials();
      //credentials != null && credentials.canRefresh
      // h   ? await _authenticator.refresh(credentials)
      //    : await _authenticator.clearCredential();

      await _authenticator.clearCredential();

      await _notifier.checkAndUpdateAuthState();

      // await _notifier.checkAndUpdateAuthState();
      // final refreshedCredential = await _authenticator.getSignedInCredentials();
      // if (refreshedCredential != null) {
      //   handler.resolve(
      //     await _dio.fetch(
      //       err.response!.requestOptions
      //         ..headers['Authorization'] =
      //             'bearer ${refreshedCredential.accessToken}',
      //     ),
      //   );
      // } else {
      //   handler.next(err);
      // }
    } else {
      handler.next(err);
    }
  }
}
