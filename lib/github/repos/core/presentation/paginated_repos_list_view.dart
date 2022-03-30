import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../../core/presentation/toastes.dart';
import '../../../core/presentation/no_result_display.dart';
import '../infrastructure/paginated_repos_notifier.dart';
import 'failure_list_tile.dart';
import 'loading_list_tile.dart';
import 'repo_tile.dart';

class PaginatedReposListView extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<PaginatedRepoNotifier,
      PaginatedReposState> paginatedRepoNotifier;
  final void Function() getNextPage;
  final String noResultMessage;
  const PaginatedReposListView({
    Key? key,
    required this.getNextPage,
    required this.paginatedRepoNotifier,
    required this.noResultMessage,
  }) : super(key: key);

  @override
  _PaginatedReposListViewState createState() => _PaginatedReposListViewState();
}

class _PaginatedReposListViewState
    extends ConsumerState<PaginatedReposListView> {
  bool canLoadNextPage = false;
  bool hasAlreadyShownToast = false;

  @override
  Widget build(BuildContext context) {
    ref.listen<PaginatedReposState>(widget.paginatedRepoNotifier,
        (previous, next) {
      next.map(
        initial: (_) => canLoadNextPage = true,
        loadInProgress: (_) => canLoadNextPage = false,
        loadSuccess: (_) {
          if (!_.repos.isFresh && !hasAlreadyShownToast) {
            hasAlreadyShownToast = true;
            showNoConnectionToast(
              context,
              "You're not online. some information may be outdated.",
            );
          }
          return canLoadNextPage = _.isNextPageAvailable;
        },
        loadFailure: (_) => canLoadNextPage = false,
      );
    });
    return Consumer(
      builder: (context, ref, childe) {
        final state = ref.watch(widget.paginatedRepoNotifier);
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            final metrics = notification.metrics;
            final limits =
                metrics.maxScrollExtent - metrics.viewportDimension / 3;

            if (metrics.pixels >= limits && canLoadNextPage) {
              widget.getNextPage();
              canLoadNextPage = false;
            }

            //! return false unless you have a very good reason to stop
            //! the notification from bubbling up to other listener up in the tree
            return false;
          },
          child: state.maybeWhen(
            loadSuccess: (repos, _) => repos.entity.isEmpty,
            orElse: () => false,
          )
              ? NoResultDisplay(
                  message: widget.noResultMessage,
                )
              : _PaginatedListView(state: state),
        );
      },
    );
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PaginatedReposState state;

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context)?.widget;
    return ListView.builder(
      padding: fsb == null
          ? EdgeInsets.zero
          : EdgeInsets.only(
              top: fsb.height + 8 + MediaQuery.of(context).padding.top,
            ),
      physics: const BouncingScrollPhysics(),
      itemCount: state.map(
        initial: (_) => 0,
        loadInProgress: (_) => _.repos.entity.length + _.itemPerPage,
        loadSuccess: (_) => _.repos.entity.length,
        loadFailure: (_) => _.repos.entity.length + 1,
      ),
      itemBuilder: (context, index) => state.map(
        initial: (_) => Container(),
        loadInProgress: (_) {
          if (index < _.repos.entity.length) {
            return RepoTile(
              repo: state.repos.entity[index],
            );
          } else {
            return const LoadingListTile();
          }
        },
        loadSuccess: (_) => RepoTile(
          repo: state.repos.entity[index],
        ),
        loadFailure: (_) {
          if (index < _.repos.entity.length) {
            return RepoTile(
              repo: state.repos.entity[index],
            );
          } else {
            return FailureListTile(_.failure);
          }
        },
      ),
    );
  }
}
