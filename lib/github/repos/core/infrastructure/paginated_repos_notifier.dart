import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/fresh.dart';
import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import '../../../core/infrastructure/pagination_config.dart';

part 'paginated_repos_notifier.freezed.dart';

typedef Repositorygetter
    = Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> Function(int page);

///we add the repo to all states because there will be repos that will show
///from the previous call which will still be showing.
///and freezed will let us access the repo field from the parent class.
///```dart
/// void test() {
///   StarredReposState? myState;
///   myState?.repo
/// }
///```
@freezed
class PaginatedReposState with _$PaginatedReposState {
  const PaginatedReposState._();
  const factory PaginatedReposState.initial(Fresh<List<GithubRepo>> repos) =
      _Initial;

  const factory PaginatedReposState.loadInProgress(
    Fresh<List<GithubRepo>> repos,
    int itemPerPage,
  ) = _LoadInProgress;

  const factory PaginatedReposState.loadSuccess(
    Fresh<List<GithubRepo>> repos, {
    required bool isNextPageAvailable,
  }) = _LoadSuccess;
  const factory PaginatedReposState.loadFailure(
    GithubFailure failure,
    Fresh<List<GithubRepo>> repos,
  ) = _LoadFailure;
}

class PaginatedRepoNotifier extends StateNotifier<PaginatedReposState> {
  PaginatedRepoNotifier() : super(PaginatedReposState.initial(Fresh.yes([])));

  // we handle pagination here.
  int _page = 1;

  @protected
  void resetState() {
    _page = 1;
    state = PaginatedReposState.initial(Fresh.yes([]));
  }

  @protected
  Future<void> getNextPage(Repositorygetter getter) async {
    state = PaginatedReposState.loadInProgress(
      state.repos,
      PaginationConfig.itemPerPage,
    );

    final failureOrRepos = await getter(_page);
    state = failureOrRepos.fold(
      (l) => PaginatedReposState.loadFailure(l, state.repos),
      (r) {
        final availability = r.isNextPageAvailable;
        if (availability != null) {
          availability ? _page++ : _page;
        }
        return PaginatedReposState.loadSuccess(
          r.copyWith(
            entity: [
              ...state.repos.entity,
              ...r.entity,
            ],
          ),
          isNextPageAvailable: r.isNextPageAvailable ?? false,
        );
      },
    );
    // state = failureOrRepos.fold(
    //   (l) => PaginatedReposState.loadFailure(l, state.repos),
    //   (r) {
    //     _page++;
    //     return PaginatedReposState.loadSuccess(
    //       r.copyWith(
    //         entity: [
    //           ...state.repos.entity,
    //           ...r.entity,
    //         ],
    //       ),
    //       isNextPageAvailable: r.isNextPageAvailable ?? false,
    //     );
    //   },
    // );
  }
}
