// ignore_for_file: depend_on_referenced_packages

// ignore: implementation_imports
import 'package:collection/src/list_extensions.dart';
import 'package:repo_viewer/github/core/domain/github_repo.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/infrastructure/sembast_database.dart';
import '../../../core/infrastructure/github_repo_dto.dart';
import '../../../core/infrastructure/pagination_config.dart';

class StarredRepoLocalService {
  final SembastDatabase _sembastDatabase;
  // use int-key in order to organize how much repos each page has.
  final _store = intMapStoreFactory.store('starredRepos');
  StarredRepoLocalService(this._sembastDatabase);

  Future<void> upsertPage(List<GithubRepoDTO> dtos, int page) async {
    final sembastPage = page - 1;

    //    page 1     ||      page 2     ||      page 3    ||
    //   0 + 3 * 0   ||     0 + 3 * 1   ||     0 + 3 * 2  ||
    //   0, 1, 2     ||     3, 4, 5     ||     6, 7, 8    ||
    await _store
        .records(
          dtos.mapIndexed(
            (index, _) => index + PaginationConfig.itemPerPage * sembastPage,
          ),
        )
        .put(
          _sembastDatabase.instance,
          dtos.map((e) => e.toJson()).toList(),
        );
  }

  Future<List<GithubRepoDTO>> getPage(int page) async {
    final sembastPage = page - 1;
    final records = await _store.find(
      _sembastDatabase.instance,
      finder: Finder(
        limit: PaginationConfig.itemPerPage,
        offset: PaginationConfig.itemPerPage * sembastPage,
      ),
    );

    return records.map((e) => GithubRepoDTO.fromJson(e.value)).toList();
  }

  Future<int> getPageCount() async {
    final recordCount = await _store.count(_sembastDatabase.instance);
    return (recordCount / PaginationConfig.itemPerPage).ceil();
  }

  Future<int> getReposCount() async {
    // return _store.count(_sembastDatabase.instance);
    return 1;
  }

  Future<void> deleteRepo(GithubRepo dto) async {
    // final records = await _store.find(
    //   _sembastDatabase.instance,
    //   finder: Finder(offset: dto.id),
    // );

    // final keyToRemove = records.removeAt(0).key;
    // await _store.record(keyToRemove).delete(_sembastDatabase.instance);
    // await _store
    //     .records(
    //       records.map((e) => e.key),
    //     )
    //     .put(
    //       _sembastDatabase.instance,
    //       records
    //           .map(
    //             (e) => e.value,
    //           )
    //           .toList(),
    //     );

    final databaseIndex = dto.id;
    // if (databaseIndex != 0) {
    // get all repos which we want to update its keys when we delete the repo.
    // the repo we want to delete is at index 0.
    final records = await _store
        .find(
          _sembastDatabase.instance,
          finder: Finder(offset: databaseIndex),
        )
        .then(
          (value) => value.map((e) => GithubRepoDTO.fromJson(e.value)).toList(),
        );
    // get the keys.
    final keysToUpdate = records.map((e) => e.id).toList();

    final lastItemKeyToDelete = keysToUpdate.last;

    // delete the repo from the records list.
    // TODO: you can use Sets to improve time complexity.
    keysToUpdate.removeLast();
    records.removeAt(0);
    final recordsToUpdate =
        records.map((e) => e.copyWith(id: e.id != 0 ? e.id - 1 : 0)).toList();

    // update database.
    // await _db.saveRecords(keysToUpdate, records);
    await _store.records(keysToUpdate).put(
          _sembastDatabase.instance,
          recordsToUpdate.map((e) => e.toJson()).toList(),
        );

    // remove the last item.
    // await _db.deleteRecord(lastItemKeyToDelete);
    await _store.record(lastItemKeyToDelete).delete(_sembastDatabase.instance);
    // } else {
    //   await _store.record(0).delete(_sembastDatabase.instance);
    // }
  }
}
