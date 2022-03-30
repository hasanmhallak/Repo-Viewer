import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

import '../../../core/infrastructure/sembast_database.dart';
import '../../core/infrastructure/github_headers_cache.dart';
import 'github_repo_detail_dto.dart';

class RepoDetailLocalService {
  static const cacheSize = 50;
  final SembastDatabase _database;
  final GithubHeadersCache _headersCache;
  final _store = stringMapStoreFactory.store('repoDetails');

  RepoDetailLocalService(this._database, this._headersCache);

  /// Updates and inserts a repo details into local storage.
  /// Will also remove the least used repos depending on the cache size.
  Future<void> upsertRepoDetail(GithubRepoDetailDTO dto) async {
    await _store.record(dto.fullName).put(_database.instance, dto.toSembast());
    final keys = await _store.findKeys(
      _database.instance,
      finder: Finder(
        sortOrders: [
          SortOrder(GithubRepoDetailDTO.lastUsedFieldName, false),
        ],
      ),
    );
    if (keys.length > cacheSize) {
      // cacheSize = 2
      // [most, less, least, lesser]
      // keys.sublist(cacheSize);
      // keysToRemove = [least, lesser]
      final keysToRemove = keys.sublist(cacheSize);
      for (final key in keysToRemove) {
        await _store.record(key).delete(_database.instance);
        await _headersCache.deleteHeaders(
          Uri.https(
            'api.github.com',
            '/repos/$key/readme',
          ),
        );
      }
    }
  }

  // we will not implement the same logic as in the search history, because delete and write a simple String
  // is not gonna cost us anything, but when it comes to a large html file, well.. it's expensive.
  /// Get the details of a given repo and updates its last used.
  ///
  /// Returns `null` if the repo is not present.
  Future<GithubRepoDetailDTO?> getRepoDetail(String fullRepoName) async {
    final record = _store.record(fullRepoName);
    // Updates the last used.
    await record.update(
      _database.instance,
      {
        GithubRepoDetailDTO.lastUsedFieldName: Timestamp.now(),
      },
    );

    // why is this??
    // to remove the repo name as it is present in the key of the record.
    // small improvements add up (: .
    final storedSnapshot = await record.getSnapshot(_database.instance);

    if (storedSnapshot == null) {
      return null;
    } else {
      return GithubRepoDetailDTO.fromSembast(storedSnapshot);
    }
  }

  /// Deletes a given repo from local storage.
  Future<void> deleteRepoDetails(String fullName) async {
    await _headersCache.deleteHeaders(
      Uri.https(
        'api.github.com',
        '/repos/$fullName/readme',
      ),
    );
    return _store.record(fullName).delete(_database.instance);
  }
}
