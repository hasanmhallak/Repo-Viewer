import 'package:sembast/sembast.dart';

import '../../../core/infrastructure/sembast_database.dart';
import 'github_headers.dart';

class GithubHeadersCache {
  final SembastDatabase _sembastDatabase;
  final _store = stringMapStoreFactory.store('headers');

  GithubHeadersCache(this._sembastDatabase);

  /// Save headers to local storage.
  Future<void> saveHeader(Uri uri, GithubHeaders headers) async {
    await _store.record(uri.toString()).put(
          _sembastDatabase.instance,
          headers.toJson(),
        );
  }

  /// Get headers from local storage.
  Future<GithubHeaders?> getHeaders(Uri uri) async {
    final json =
        await _store.record(uri.toString()).get(_sembastDatabase.instance);
    return json == null ? null : GithubHeaders.fromJson(json);
  }

  /// Deletes headers from local storage.
  Future<void> deleteHeaders(Uri uri) async {
    await _store.record(uri.toString()).delete(_sembastDatabase.instance);
  }
}
