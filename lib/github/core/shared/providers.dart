import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/shared/providers.dart';
import '../../details/application/repo_detail_notifier.dart';
import '../../details/infrastructure/repo_detail_local_service.dart';
import '../../details/infrastructure/repo_detail_remote_service.dart';
import '../../details/infrastructure/repo_detail_repository.dart';
import '../../repos/core/infrastructure/paginated_repos_notifier.dart';
import '../../repos/searched_repo/application/searched_repos_notifier.dart';
import '../../repos/searched_repo/infrastructure/searched_repos_remote_service.dart';
import '../../repos/searched_repo/infrastructure/searched_repos_repository.dart';
import '../../repos/starred_repos/application/starred_repo_notifier.dart';
import '../../repos/starred_repos/infrastructure/starred_repo_local_service.dart';
import '../../repos/starred_repos/infrastructure/starred_repo_remote_service.dart';
import '../../repos/starred_repos/infrastructure/starred_repo_repository.dart';
import '../infrastructure/github_headers_cache.dart';

final githubHeadersCacheProvider = Provider(
  (ref) => GithubHeadersCache(
    ref.watch(sembastProvider),
  ),
);

final starredRepoLocalServiceProvider = Provider(
  (ref) => StarredRepoLocalService(
    ref.watch(sembastProvider),
  ),
);

final starredRepoRemoteServiceProvider = Provider(
  (ref) => StarredRepoRemoteService(
    ref.watch(dioForRepo),
    ref.watch(githubHeadersCacheProvider),
  ),
);

final starredRepoRepository = Provider(
  (ref) => StarredRepoRepository(
    ref.watch(starredRepoRemoteServiceProvider),
    ref.watch(starredRepoLocalServiceProvider),
  ),
);

final starredReposNotifierProvider =
    StateNotifierProvider.autoDispose<StarredRepoNotifier, PaginatedReposState>(
  (ref) => StarredRepoNotifier(
    ref.watch(starredRepoRepository),
  ),
);
final searchedRepoRemoteServiceProvider = Provider(
  (ref) => SearchedRepoRemoteService(
    ref.watch(dioForRepo),
    ref.watch(githubHeadersCacheProvider),
  ),
);

final searchedReposRepository = Provider(
  (ref) => SearchedReposRepository(
    ref.watch(searchedRepoRemoteServiceProvider),
  ),
);

final searchedReposNotifierProvider = StateNotifierProvider.autoDispose<
    SearchedReposNotifier, PaginatedReposState>(
  (ref) => SearchedReposNotifier(
    ref.watch(searchedReposRepository),
  ),
);

final repoDetailLocalService = Provider(
  (ref) => RepoDetailLocalService(
    ref.watch(sembastProvider),
    ref.watch(githubHeadersCacheProvider),
  ),
);

final repoDetailRemoteService = Provider(
  (ref) => RepoDetailRemoteService(
    ref.watch(dioForRepo),
    ref.watch(githubHeadersCacheProvider),
  ),
);
final repoDetailRepository = Provider(
  (ref) => RepoDetailRepository(
    ref.watch(repoDetailLocalService),
    ref.watch(repoDetailRemoteService),
  ),
);

// will not add auto dispose because user might enter the page, switch star status
// and pop the screen before we continue the request.
final repoDetailNotifierProvider =
    // we need to state to be dispose whenever the page pop.
    StateNotifierProvider.autoDispose<RepoDetailNotifier, RepoDetailState>(
  (ref) => RepoDetailNotifier(
    ref.watch(repoDetailRepository),
  ),
);
