import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../auth/shared/providers.dart';
import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../../search/presentation/search_bar.dart';
import '../../../core/shared/providers.dart';
import '../../core/presentation/paginated_repos_list_view.dart';

class SearchedReposPage extends ConsumerStatefulWidget {
  final String searchTerm;
  const SearchedReposPage({Key? key, required this.searchTerm})
      : super(key: key);

  @override
  _SearchedReposPageState createState() => _SearchedReposPageState();
}

class _SearchedReposPageState extends ConsumerState<SearchedReposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(searchedReposNotifierProvider.notifier)
          .getFirstSearchedReposPage(widget.searchTerm),
    );

    //or
    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBar(
        openDrawer: null,
        title: widget.searchTerm,
        hintText: 'Search all repositories...',
        onShouldNavigateToResultPage: (searchTerm) {
          AutoRouter.of(context).pushAndPopUntil(
            SearchedReposRoute(searchTerm: searchTerm),
            predicate: (route) => route.settings.name == DrawerStateRoute.name,
          );
        },
        onSignOut: () => ref.read(authProvider.notifier).signOut(),
        body: PaginatedReposListView(
          getNextPage: () {
            ref
                .read(searchedReposNotifierProvider.notifier)
                .getNextSearchedReposPage(widget.searchTerm);
          },
          paginatedRepoNotifier: searchedReposNotifierProvider,
          noResultMessage:
              "This is all we could find for your search term. Really...",
        ),
      ),
    );
  }
}
