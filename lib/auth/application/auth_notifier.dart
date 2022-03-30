import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/auth_failure.dart';
import '../infrastructure/github_authenticatore.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Inintial;
  const factory AuthState.unAuthenticated() = _UnAuthenticated;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

//we need to pass the Auth uri to the web view and get the redirected uri back from the web view
//so we can call the method from infrastructure to handle the response.
typedef AuthUriCallback = Future<Uri> Function(Uri authUri);

class AuthNotifier extends StateNotifier<AuthState> {
  final Github _authenticator;
  AuthNotifier(this._authenticator) : super(const AuthState.initial());

  /// Updates the `state` with user's authentication status.
  ///
  /// `AuthState.authenticated` or `AuthState.unAuthenticated`.
  Future<void> checkAndUpdateAuthState() async {
    state = (await _authenticator.isSignedIn)
        ? const AuthState.authenticated()
        : const AuthState.unAuthenticated();
  }

  /// Fires the `OAuth2` authentication flow and updates the state with `AuthState.failure` or `AuthState.authenticated`.
  ///
  /// [authCallback] must navigate to a `WebView` with initial URL to which the resource owner should be redirected to authorize this client.
  ///
  Future<void> signIn(AuthUriCallback authCallback) async {
    // create a grant.
    final grant = _authenticator.createGrand();
    // prompt user to signIn and get the redirected uri with a code.
    final redirectedUrl =
        await authCallback(_authenticator.getAuthorizationUrl(grant));
    // exchange the code for access token.
    final failureOrSuccess = await _authenticator.handelAuthorizationResponse(
      grant,
      redirectedUrl.queryParameters,
    );
    state = failureOrSuccess.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.authenticated(),
    );
    grant.close();
  }

  /// Signs user out and updates the state with `AuthState.failure` or `AuthState.unAuthenticated`.
  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();
    state = failureOrSuccess.fold(
      (l) => AuthState.failure(l),
      (r) => const AuthState.unAuthenticated(),
    );
  }
}
