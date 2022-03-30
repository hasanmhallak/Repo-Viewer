import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/presentation/toastes.dart';
import '../../core/domain/github_repo.dart';
import '../../core/presentation/no_result_display.dart';
import '../../core/shared/providers.dart';
import '../../repos/core/presentation/repo_tile.dart';
import '../application/repo_detail_notifier.dart';
import 'html.dart';

class RepoDetailPage extends ConsumerStatefulWidget {
  final GithubRepo repo;
  const RepoDetailPage(
    this.repo, {
    Key? key,
  }) : super(key: key);

  @override
  _RepoDetailPageState createState() => _RepoDetailPageState();
}

class _RepoDetailPageState extends ConsumerState<RepoDetailPage> {
  @override
  void initState() {
    super.initState();
    // wait as little time as possible to get the context.
    Future.microtask(
      () {
        ref.read(repoDetailNotifierProvider.notifier).resetState();
        return ref
            .read(repoDetailNotifierProvider.notifier)
            .getRepoDetail(widget.repo.fullName);
      },
    );
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<RepoDetailState>(repoDetailNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        loadSuccess: (repoDetail, _) {
          if (!repoDetail.isFresh) {
            showNoConnectionToast(
              context,
              "You're not online. some information may be outdated.",
            );
          }
        },
      );
    });

    return Consumer(
      builder: (context, notifier, child) {
        final state = notifier.watch(repoDetailNotifierProvider);
        return WillPopScope(
          onWillPop: () async {
            if (state.hasStarredStatusChanged) {
              ref
                  .read(starredReposNotifierProvider.notifier)
                  .getFirstStarredReposPage();
            }

            ///TODO: might the error be here
            // ref.read(repoDetailNotifierProvider.notifier).resetState();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Hero(
                    tag: widget.repo.fullName,
                    child: image1(widget.repo.owner.avatarUrlSmall, 16),
                  ),
                  const SizedBox(width: 8),
                  Flexible(child: Text(widget.repo.name)),
                ],
              ),
              actions: [
                state.maybeMap(
                  orElse: () {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade300,
                      child: IconButton(
                        icon: const Icon(Icons.star),
                        // if null, color will be brighter.
                        onPressed: null,
                        disabledColor: Theme.of(context).iconTheme.color,
                      ),
                    );
                  },
                  loadSuccess: (state) {
                    // because of name shadowing, this state will not infer with the above state.
                    return IconButton(
                      icon: Icon(
                        !state.repoDetail.isFresh
                            ? MdiIcons.starRemoveOutline
                            : state.repoDetail.entity?.isStarred == true
                                ? Icons.star
                                : Icons.star_outline,
                      ),
                      onPressed: !state.repoDetail.isFresh
                          ? null
                          : () {
                              ref
                                  .read(repoDetailNotifierProvider.notifier)
                                  // we can't arrive here if it's null, cause the data won't be Fresh.
                                  .switchStarredStatus(
                                    state.repoDetail.entity!,
                                    widget.repo,
                                    ref,
                                  );
                            },
                    );
                  },
                )
              ],
            ),
            body: state.map(
              initial: (_) => Container(),
              loadInProgress: (_) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loadSuccess: (_) {
                if (_.repoDetail.entity == null) {
                  return const NoResultDisplay(
                    message:
                        'These are approximately all the details we could find about this repo right now.',
                  );
                } else {
                  return WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    navigationDelegate: (navigation) {
                      if (navigation.url.contains('data:')) {
                        return NavigationDecision.navigate;
                      } else {
                        url_launcher.launch(navigation.url);
                        return NavigationDecision.prevent;
                      }
                    },
                    initialUrl: htmlPage(body: _.repoDetail.entity!.html),
                  );
                }
              },
              loadFailure: (_) => Text(_.failure.errorCode.toString()),
            ),
          ),
        );
      },
    );
  }
}
