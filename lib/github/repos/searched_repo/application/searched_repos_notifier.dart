import '../../core/infrastructure/paginated_repos_notifier.dart';
import '../infrastructure/searched_repos_repository.dart';

class SearchedReposNotifier extends PaginatedRepoNotifier {
  final SearchedReposRepository _repository;
  SearchedReposNotifier(this._repository);

  Future<void> getFirstSearchedReposPage(String query) async {
    super.resetState();
    await getNextSearchedReposPage(query);
  }

  Future<void> getNextSearchedReposPage(String query) async {
    super.getNextPage((page) => _repository.getSearchedRepoPage(page, query));
  }
}
