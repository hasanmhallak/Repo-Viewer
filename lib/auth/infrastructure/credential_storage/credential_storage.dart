import 'dart:async';
import 'package:oauth2/oauth2.dart';

abstract class CredentialStorage {
  /// Decrypts and return credentials from local storage or from cache.
  ///
  /// Can throw a [PlatformException].
  Future<Credentials?> read();

  /// Encrypts and saves credentials in local storage and from cache.
  ///
  /// Can throw a [PlatformException].
  Future<void> save(Credentials credentials);

  /// Deletes credentials from local storage and from cache.
  ///
  /// Can throw a [PlatformException].
  Future<void> clear();
}
