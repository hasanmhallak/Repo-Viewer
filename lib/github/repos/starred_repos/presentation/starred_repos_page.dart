import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/shared/providers.dart';
import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../../search/presentation/search_bar.dart';
import '../../../core/shared/providers.dart';
import '../../core/presentation/paginated_repos_list_view.dart';

class StarredReposPage extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;
  const StarredReposPage({
    Key? key,
    required this.openDrawer,
  }) : super(key: key);
  @override
  _StarredReposPageState createState() => _StarredReposPageState();
}

class _StarredReposPageState extends ConsumerState<StarredReposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(starredReposNotifierProvider.notifier)
          .getFirstStarredReposPage(),
    );

    // or
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBar(
        openDrawer: widget.openDrawer,
        title: 'Starred repositories',
        hintText: 'Search all repositories...',
        onShouldNavigateToResultPage: (searchTerm) {
          AutoRouter.of(context)
              .push(SearchedReposRoute(searchTerm: searchTerm));
        },
        onSignOut: () => ref.read(authProvider.notifier).signOut(),
        body: PaginatedReposListView(
          getNextPage: () {
            ref
                .read(starredReposNotifierProvider.notifier)
                .getNextStarredReposPage();
          },
          paginatedRepoNotifier: starredReposNotifierProvider,
          noResultMessage:
              "That's about everything we could find in your starred repos right now.",
        ),
      ),
    );
  }
}
