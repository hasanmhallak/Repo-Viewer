import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/search_history_repository.dart';

class SearchHistoryNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final SearchHistoryRepository _repository;
  SearchHistoryNotifier(this._repository) : super(const AsyncValue.loading());

  void watchSearchTerm({String? filter}) {
    _repository.watchSearchTerm(filter: filter).listen(
      (data) {
        state = AsyncValue.data(data);
      },
      onError: (Object error) => AsyncValue.error(error),
    );
  }

  Future<void> addSearchTerm(String term) => _repository.addSearchTerm(term);
  Future<void> deleteSearchTerm(String term) =>
      _repository.deleteSearchTerm(term);
  Future<void> putSearchedTermFirst(String term) =>
      _repository.putSearchedTermFirst(term);
}
