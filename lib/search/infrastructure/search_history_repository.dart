import 'package:sembast/sembast.dart';

import '../../core/infrastructure/sembast_database.dart';

class SearchHistoryRepository {
  final SembastDatabase _database;
  final _store = StoreRef<int, String>('searchHistory');
  SearchHistoryRepository(this._database);

  static const historyLength = 10;

  Stream<List<String>> watchSearchTerm({String? filter}) {
    return _store
        .query(
          finder: filter != null && filter.isNotEmpty
              ? Finder(
                  filter: Filter.custom(
                    (record) => (record.value as String).startsWith(filter),
                  ),
                )
              : null,
        )
        .onSnapshots(_database.instance)
        .map(
          (records) => records.reversed
              .map(
                (e) => e.value,
              )
              .toList(),
        );
  }

  // Application layer must not deal with database instance and should only provide the search term.
  Future<void> addSearchTerm(String term) =>
      _addSearchTerm(term, _database.instance);

  Future<void> _addSearchTerm(String term, DatabaseClient db) async {
    final existingKey = await _store.findKey(
      db,
      finder: Finder(filter: Filter.custom((record) => record.value == term)),
    );

    if (existingKey != null) {
      await putSearchedTermFirst(term);
      return;
    }
    await _store.add(db, term);
    final count = await _store.count(db);
    if (count > historyLength) {
      await _store.delete(
        db,
        finder: Finder(limit: count - historyLength),
      );
    }
  }

  // Application layer must not deal with database instance and should only provide the search term.
  Future<void> deleteSearchTerm(String term) =>
      _deleteSearchTerm(term, _database.instance);

  Future<void> _deleteSearchTerm(String term, DatabaseClient db) async {
    await _store.delete(
      db,
      finder: Finder(filter: Filter.custom((record) => record.value == term)),
    );
  }

  Future<void> putSearchedTermFirst(String term) async {
    //! do not use multi database instance at the same time, to prevent database lock.
    // await deleteSearchTerm(term);
    // await addSearchTerm(term);
    await _database.instance.transaction((transaction) async {
      await _deleteSearchTerm(term, transaction);
      await _addSearchTerm(term, transaction);
    });
  }
}
