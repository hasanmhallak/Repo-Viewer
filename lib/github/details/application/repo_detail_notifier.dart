import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repo_viewer/github/core/domain/github_repo.dart';
import 'package:repo_viewer/github/core/shared/providers.dart';

import '../../../core/domain/fresh.dart';
import '../../core/domain/github_failure.dart';
import '../domain/github_repo_detail.dart';
import '../infrastructure/repo_detail_repository.dart';

part 'repo_detail_notifier.freezed.dart';

// we include state, because we want to have something to indicate if the state is changed
// so we can update the repos page.
@freezed
class RepoDetailState with _$RepoDetailState {
  const RepoDetailState._();
  const factory RepoDetailState.initial({
    @Default(false) bool hasStarredStatusChanged,
  }) = _Initial;

  const factory RepoDetailState.loadInProgress({
    @Default(false) bool hasStarredStatusChanged,
  }) = _LoadInProgress;

  const factory RepoDetailState.loadSuccess(
    Fresh<GithubRepoDetail?> repoDetail, {
    @Default(false) bool hasStarredStatusChanged,
  }) = _LoadSuccess;

  const factory RepoDetailState.loadFailure(
    GithubFailure failure, {
    @Default(false) bool hasStarredStatusChanged,
  }) = _LoadFailure;
}

class RepoDetailNotifier extends StateNotifier<RepoDetailState> {
  final RepoDetailRepository _repository;

  RepoDetailNotifier(this._repository) : super(const RepoDetailState.initial());

  void resetState() {
    state = const RepoDetailState.initial();
  }

  /// Updates notifier state with `Either<GithubFailure, Fresh<GithubRepoDetail?>>`.
  Future<void> getRepoDetail(String fullRepoName) async {
    final failureOrRepoDetail = await _repository.getRepoDetail(fullRepoName);
    state = failureOrRepoDetail.fold(
      (l) => RepoDetailState.loadFailure(l),
      (r) => RepoDetailState.loadSuccess(r),
    );
  }

  // Optimistices Updates is when you optimistically assume that you're request
  // has been succeeded and and update the UI instantly. and when you receive the response
  // and it's a failure then you will update the UI again.
  // always use this with icons and buttons, to not make the user feels that there's a lag.
  Future<void> switchStarredStatus(
      GithubRepoDetail repoDetail, GithubRepo repo, WidgetRef ref) async {
    // in order for us to reverse back to the previouse state, we must call this method
    // only if the state was _LoadSuccess because it's the only state that has
    // the starred state.

    // State can't be access unless it's mapped.
    state.maybeMap(
      orElse: () {},
      loadSuccess: (successState) async {
        // so we can reverse back to it.
        final stateCopy = successState.copyWith();
        final repoDetail = successState.repoDetail.entity;
        if (repoDetail != null) {
          // deep copy.

          state = successState.copyWith.repoDetail(
            // optimistic update.
            // update the starred state.
            entity: repoDetail.copyWith(isStarred: !repoDetail.isStarred),
          );

          final failureOrSuccess =
              await _repository.switchStarredStatus(repoDetail);
          failureOrSuccess.fold(
            // if failure reverse start state.

            (l) => state = stateCopy,
            (r) async {
              if (r == null) {
                return state = stateCopy;
              } else {
                //TODO: implements delete.
                await ref
                    .read(starredReposNotifierProvider.notifier)
                    .deleteStarredRepo(repo);
                return state = state.copyWith(
                  hasStarredStatusChanged: true,
                );
              }
            },
          );
        }
      },
    );
  }
}
