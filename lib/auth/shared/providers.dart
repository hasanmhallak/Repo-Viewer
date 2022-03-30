import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

import '../application/auth_notifier.dart';
import '../infrastructure/credential_storage/credential_storage.dart';
import '../infrastructure/credential_storage/secure_credential_storage.dart';
import '../infrastructure/github_authenticatore.dart';
import '../infrastructure/oauth2_interceptore.dart';

final flutterSecureStorageProvider = Provider(
  (ref) => const FlutterSecureStorage(),
);

final credentialsStoreageProvider = Provider<CredentialStorage>(
  (ref) => SecureCredentialStorage(ref.watch(flutterSecureStorageProvider)),
);

final dioProvider = Provider(
  (ref) => Dio(),
);

final oAuth2InterceptorProvider = Provider(
  (ref) => OAuth2Interceptore(
    ref.watch(githubAuthenticator),
    ref.watch(authProvider.notifier),
    ref.watch(dioProvider),
  ),
);

final githubAuthenticator = Provider(
  (ref) => Github(
    ref.watch(credentialsStoreageProvider),
    ref.watch(dioProvider),
  ),
);

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    ref.watch(githubAuthenticator),
  ),
);
