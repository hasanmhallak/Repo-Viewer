import '../../../core/domain/github_repo.dart';

import '../../core/infrastructure/paginated_repos_notifier.dart';
import '../infrastructure/starred_repo_repository.dart';

class StarredRepoNotifier extends PaginatedRepoNotifier {
  final StarredRepoRepository _repository;
  StarredRepoNotifier(this._repository);

  // call it the starred repos status changed.
  // when we star a new repo.
  Future<void> getFirstStarredReposPage() async {
    super.resetState();
    await getNextStarredReposPage();
  }

  Future<void> getNextStarredReposPage() async {
    super.getNextPage((page) => _repository.getStarredRepo(page));
  }

  Future<void> deleteStarredRepo(GithubRepo repo) async {
    await _repository.deleteRepo(repo);
  }
}
