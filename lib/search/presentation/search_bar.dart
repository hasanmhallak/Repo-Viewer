import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../shared/provider.dart';

class SearchBar extends ConsumerStatefulWidget {
  final String title;
  final String hintText;
  final Widget body;
  final void Function(String searchTerm) onShouldNavigateToResultPage;
  final void Function() onSignOut;
  final VoidCallback? openDrawer;

  const SearchBar({
    required this.title,
    required this.hintText,
    required this.body,
    required this.onShouldNavigateToResultPage,
    required this.onSignOut,
    required this.openDrawer,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  late FloatingSearchBarController _controller;
  @override
  void initState() {
    super.initState();
    _controller = FloatingSearchBarController();
    // context.read(searchHistoryNotifierProvider.notifier).watchSearchTerm();
    Future.microtask(
      () => ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerm(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // nested function can only be called within the parent function [build].
    void pushPageAndPutFirstInHistory(String term) {
      widget.onShouldNavigateToResultPage(term);
      ref
          .read(searchHistoryNotifierProvider.notifier)
          .putSearchedTermFirst(term);
      _controller.close();
    }

    void pushPageAndAddToHistory(String term) {
      widget.onShouldNavigateToResultPage(term);
      ref.read(searchHistoryNotifierProvider.notifier).addSearchTerm(term);
      _controller.close();
    }

    void deleteSearchTerm(String term) {
      ref.read(searchHistoryNotifierProvider.notifier).deleteSearchTerm(term);
    }

    return FloatingSearchBar(
      controller: _controller,
      body: FloatingSearchBarScrollNotifier(child: widget.body),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            'Tap to search',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      hint: widget.hintText,
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        FloatingSearchBarAction(
          child: IconButton(
            icon: const Icon(MdiIcons.logoutVariant),
            splashRadius: 18,
            onPressed: widget.onSignOut,
          ),
        ),
        FloatingSearchBarAction(
          child: IconButton(
            icon: const Icon(Icons.menu_rounded),
            splashRadius: 18,
            onPressed: widget.openDrawer,
          ),
        )
      ],
      onQueryChanged: (query) {
        ref
            .read(searchHistoryNotifierProvider.notifier)
            .watchSearchTerm(filter: query);
      },
      onSubmitted: pushPageAndAddToHistory,
      builder: (context, transition) {
        // splash effect are drowned on the nearest material widget.
        // so the splash of the [ListTile] are drown here.
        return Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          // to notify the [ListTile] about the clipBehavior. In this case [borderRadius].
          clipBehavior: Clip.hardEdge,
          child: Consumer(
            builder: (BuildContext context, WidgetRef notifier, Widget? child) {
              final state = notifier.watch(searchHistoryNotifierProvider);
              return state.map(
                data: (history) {
                  if (history.value.isEmpty && _controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching...',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (history.value.isEmpty) {
                    return ListTile(
                      leading: const Icon(MdiIcons.magnify),
                      title: Text(_controller.query),
                      onTap: () => pushPageAndAddToHistory(_controller.query),
                    );
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: history.value.map((term) {
                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(
                          term,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () => deleteSearchTerm(term),
                          icon: const Icon(Icons.close),
                          splashRadius: 20,
                        ),
                        onTap: () => pushPageAndPutFirstInHistory(term),
                      );
                    }).toList(),
                  );
                },
                loading: (_) => const ListTile(
                  title: LinearProgressIndicator(),
                ),
                error: (_) => throw _.error,
              );
            },
          ),
        );
      },
    );
  }
}
