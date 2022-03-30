import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;
import 'package:repo_viewer/github/repos/core/infrastructure/paginated_repos_notifier.dart';
import 'package:sizer/sizer.dart';

import '../../core/presentation/toastes.dart';
import '../../github/core/shared/providers.dart';
import '../../github/details/application/repo_detail_notifier.dart';
import '../../github/repos/core/presentation/repo_tile.dart';
import '../application/authenticated_user_notifier.dart';
import '../shared/providers.dart';

class CostumeDrawer extends StatelessWidget {
  const CostumeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CostumeDrawerItems();
  }
}

class CostumeDrawerItems extends ConsumerWidget {
  const CostumeDrawerItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RepoDetailState>(
      repoDetailNotifierProvider,
      (previous, next) {
        if (next.hasStarredStatusChanged) {
          ref.read(authUserNotifierProvider.notifier).getUserInfo();
        }
      },
    );
    ref.listen<PaginatedReposState>(starredReposNotifierProvider,
        (previous, next) {
      next.maybeWhen(
        orElse: () {},
        loadSuccess: (repoDetail, hasStarredStatusChanged) {
          ref.read(authUserNotifierProvider.notifier).getUserInfo();
        },
      );
    });
    ref.listen<AuthenticatedUserState>(authUserNotifierProvider,
        (previous, next) {
      previous?.maybeMap(
        orElse: () {},
        loadSuccess: (state) {
          if (!state.authUser.isFresh) {
            showNoConnectionToast(
              context,
              "You're not online. some information may be outdated.",
            );
          }
        },
      );
    });
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(authUserNotifierProvider);
        return state.when(
          initial: () {
            return const CircularProgressIndicator();
          },
          loadSuccess: (_) {
            return DrawerPage(
              avatarUrl: _.entity?.avatarUrlSmall ?? '',
              name: _.entity?.name ?? '',
              username: _.entity?.userName ?? '',
              followers: _.entity?.followers ?? 0,
              following: _.entity?.following ?? 0,
              starCount: _.entity?.starredRepos ?? 0,
            );
          },
          loadFailure: (failure) {
            return Text(failure.errorCode.toString());
          },
        );
      },
    );
  }
}

class DrawerPage extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String username;
  final int followers;
  final int following;
  final int starCount;
  const DrawerPage({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.username,
    required this.followers,
    required this.following,
    required this.starCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          // height: double.infinity,
          width: 59.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
            child: Column(
              children: [
                image1(avatarUrl, 50),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.headline5,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '@$username',
                  style: Theme.of(context).textTheme.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 12,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CountCard(
                        color: Colors.grey.shade600,
                        icon: Icons.people_alt,
                        number: followers,
                        name: 'followers',
                      ),
                      CountCard(
                        color: Colors.grey.shade600,
                        icon: Icons.people_alt,
                        number: following,
                        name: 'following',
                      ),
                      CountCard(
                        // TODO: implement star count.
                        color: Colors.yellow.shade600,
                        icon: Icons.star_purple500_outlined,
                        number: starCount,
                        name: 'repositories',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CountCard extends StatelessWidget {
  final int number;
  final String name;
  final IconData icon;
  final Color color;
  const CountCard({
    Key? key,
    required this.number,
    required this.name,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 6),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${format(number)} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String format(int number) {
  return intl.NumberFormat.compact().format(number);
}
