import 'package:dartz/dartz.dart';

import '../../../core/domain/fresh.dart';
import '../../../core/infrastructure/rest_api_exception.dart';
import '../../core/domain/github_failure.dart';
import '../domain/github_repo_detail.dart';
import 'github_repo_detail_dto.dart';
import 'repo_detail_local_service.dart';
import 'repo_detail_remote_service.dart';

class RepoDetailRepository {
  final RepoDetailLocalService _localService;
  final RepoDetailRemoteService _remoteService;

  RepoDetailRepository(this._localService, this._remoteService);

  /// Returns `right(null)` if there's no internet connection.
  Future<Either<GithubFailure, Unit?>> switchStarredStatus(
    GithubRepoDetail repoDetail,
  ) async {
    try {
      final actionCompleted = await _remoteService.switchStarredStatus(
        repoDetail.fullName,
        isStarred: repoDetail.isStarred,
      );
      // if the request succeeded and repo was starred => it's not starred now.
      // looks dump, but it's a good point.
      if (actionCompleted != null && repoDetail.isStarred) {
        await _localService.deleteRepoDetails(repoDetail.fullName);
      }
      return right(actionCompleted);
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCoed));
    }
  }

  // GithubRepoDetail is nullable because we don't have any list as in the repos.
  Future<Either<GithubFailure, Fresh<GithubRepoDetail?>>> getRepoDetail(
    String fullRepoName,
  ) async {
    try {
      final htmlRemoteResponse = await _remoteService.getHtml(fullRepoName);
      return right(
        await htmlRemoteResponse.when(
          noConnection: () async => Fresh.no(
            await _localService
                .getRepoDetail(fullRepoName)
                .then((dto) => dto?.toDomain()),
          ),
          notModified: (_) async {
            final cached = await _localService.getRepoDetail(fullRepoName);
            // there's no eTag on this end point, so we always gonna get it from remote service.
            final isStarred =
                await _remoteService.getStarredStatus(fullRepoName);
            final withUpdatedStarredField =
                cached?.copyWith(isStarred: isStarred ?? false);
            return Fresh.yes(withUpdatedStarredField?.toDomain());
          },
          withData: (html, _) async {
            final isStarred =
                await _remoteService.getStarredStatus(fullRepoName);
            final dto = GithubRepoDetailDTO(
              fullName: fullRepoName,
              html: html,
              isStarred: isStarred ?? false,
            );
            await _localService.upsertRepoDetail(dto);
            return Fresh.yes(dto.toDomain());
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCoed));
    }
  }
}
