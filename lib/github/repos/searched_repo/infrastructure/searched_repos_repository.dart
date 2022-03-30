import 'package:dartz/dartz.dart';

import '../../../../core/domain/fresh.dart';
import '../../../../core/infrastructure/rest_api_exception.dart';
import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import '../../core/infrastructure/extesion.dart';
import 'searched_repos_remote_service.dart';

class SearchedReposRepository {
  final SearchedRepoRemoteService _remoteService;

  SearchedReposRepository(this._remoteService);

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getSearchedRepoPage(
    int page,
    String query,
  ) async {
    try {
      final remotePageItems = await _remoteService.getSearchedRepo(page, query);
      return right(
        remotePageItems.maybeWhen(
          orElse: () => Fresh.no([]),
          withData: (data, maxPage) => Fresh.yes(
            data.toDoamin(),
            isNextPageAvailable: page < maxPage,
          ),
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCoed));
    }
  }
}
