import 'package:flutter/material.dart';

import '../../../core/domain/github_failure.dart';
import 'paginated_repos_list_view.dart';

class FailureListTile extends StatelessWidget {
  final GithubFailure failure;
  const FailureListTile(
    this.failure, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      textColor: Theme.of(context).colorScheme.onError,
      iconColor: Theme.of(context).colorScheme.onError,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        color: Theme.of(context).colorScheme.error,
        child: ListTile(
          leading: const SizedBox(
            height: double.infinity,
            child: Icon(
              Icons.warning_amber_rounded,
            ),
          ),
          title: const Text('An error accrued, please try again later.'),
          subtitle: Text(
            failure.when(api: (number) => 'Error code: $number'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // context
              //     .read(starredReposNotifierProvider.notifier)
              //     .getNextStarredReposPage();
              context
                  .findAncestorWidgetOfExactType<PaginatedReposListView>()
                  ?.getNextPage();
            },
          ),
        ),
      ),
    );
  }
}
