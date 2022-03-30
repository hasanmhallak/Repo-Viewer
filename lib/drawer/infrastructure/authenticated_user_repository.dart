import 'package:dartz/dartz.dart';
import 'package:repo_viewer/github/repos/starred_repos/infrastructure/starred_repo_local_service.dart';

import '../../core/domain/fresh.dart';
import '../../core/infrastructure/rest_api_exception.dart';
import '../../github/core/domain/github_failure.dart';
import '../domain/authenticated_user.dart';
import 'authenticated_user_local_service.dart';
import 'authenticated_user_remote_service.dart';

class AuthenticatedUserRepository {
  final AuthenticatedUserRemoteService _remoteService;
  final AuthenticatedUserLocalService _localService;
  final StarredRepoLocalService _repoLocalService;

  AuthenticatedUserRepository(
      this._remoteService, this._localService, this._repoLocalService);

  Future<Either<GithubFailure, Fresh<AuthenticatedUser?>>> getUser() async {
    try {
      final remoteResponse = await _remoteService.getUserInfo();
      final starCount = await _repoLocalService.getReposCount();
      return right(
        await remoteResponse.when(
          noConnection: () async => Fresh.no(
            await _localService.getUser().then(
                  (dto) => dto?.toDoamin(),
                ),
          ),
          notModified: (_) async {
            final dto = await _localService.getUser();
            final dtoCopy = dto?.copyWith(starredRepos: starCount);
            if (dtoCopy != null) {
              await _localService.upsertUser(dtoCopy);
            }

            return Fresh.yes(
              dtoCopy?.toDoamin(),
            );
          },
          withData: (dto, _) async {
            final dtoCopy = dto.copyWith(starredRepos: starCount);
            await _localService.upsertUser(dtoCopy);
            return Fresh.yes(dtoCopy.toDoamin());
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCoed));
    }
  }
}
