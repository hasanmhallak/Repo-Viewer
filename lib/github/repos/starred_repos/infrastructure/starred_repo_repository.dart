import 'package:dartz/dartz.dart';

import '../../../../core/domain/fresh.dart';
import '../../../../core/infrastructure/rest_api_exception.dart';
import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import '../../core/infrastructure/extesion.dart';
import 'starred_repo_local_service.dart';
import 'starred_repo_remote_service.dart';

class StarredRepoRepository {
  final StarredRepoRemoteService _remoteService;
  final StarredRepoLocalService _localService;

  StarredRepoRepository(this._remoteService, this._localService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredRepo(
    int page,
  ) async {
    try {
      final remoteResponse = await _remoteService.getStarredRepo(page);

      return right(
        await remoteResponse.when(
          noConnection: () async => Fresh.no(
            await _localService.getPage(page).then((_) => _.toDoamin()),
            isNextPageAvailable: page < await _localService.getPageCount(),
          ),
          notModified: (maxPage) async => Fresh.yes(
            await _localService.getPage(page).then((_) => _.toDoamin()),
            isNextPageAvailable: page < maxPage,
          ),
          withData: (data, maxPage) async {
            await _localService.upsertPage(data, page);
            return Fresh.yes(
              data.toDoamin(),
              isNextPageAvailable: page < maxPage,
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCoed));
    }
  }

  Future<void> deleteRepo(GithubRepo repo) async {
    return _localService.deleteRepo(repo);
  }
}
