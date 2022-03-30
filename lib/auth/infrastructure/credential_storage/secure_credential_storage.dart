import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'credential_storage.dart';

class SecureCredentialStorage implements CredentialStorage {
  // Injecting Secure Storage instance.
  final FlutterSecureStorage _storage;

  // Define a key for the Storage.
  static const _key = 'oauth2_credentials';

  // Caching credentials in memory.

  // This will reduce the time needed to retrive credentials from local Storage
  // when the app is running.
  Credentials? _cachedCredentials;

  SecureCredentialStorage(this._storage);

  @override
  Future<void> clear() {
    // Clearing caches.
    _cachedCredentials = null;

    // Clearing local storage.
    return _storage.delete(key: _key);
  }

  @override
  Future<Credentials?> read() async {
    // Checking caches.
    if (_cachedCredentials != null) {
      return _cachedCredentials;
    } else {
      // Reading local storage.
      final json = await _storage.read(key: _key);
      if (json == null) {
        return null;
      } else {
        try {
          // Can throw [FormatException] if Json is incorrectly formatted.
          return _cachedCredentials = Credentials.fromJson(json);
        } on FormatException {
          return null;
        }
      }
    }
  }

  @override
  Future<void> save(Credentials credentials) {
    // Caching credentials.
    _cachedCredentials = credentials;

    // Reading local storage.
    // We can ignore the async modifier because the return type matches.
    return _storage.write(key: _key, value: credentials.toJson());
  }
}
