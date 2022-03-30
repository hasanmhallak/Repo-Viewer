import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../core/domain/github_repo.dart';

// ignore: must_be_immutable
class RepoTile extends StatelessWidget {
  final GithubRepo repo;
  Widget? text;
  RepoTile({
    Key? key,
    required this.repo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: repo.fullName,
        child: image1(repo.owner.avatarUrlSmall),
      ),
      title: Text(repo.name),
      subtitle: Text(
        repo.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star_outline),
          Text(
            repo.stargazerCount.toString(),
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      onTap: () {
        AutoRouter.of(context).push(
          RepoDetailRoute(repo: repo),
        );
      },
    );
  }
}

Widget image1(String uri, [double? radius]) {
  return CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: radius,
    child: Container(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      // height: 50,
      // width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: ImageProvider(uri),
    ),
  );
}

class ImageProvider extends StatelessWidget {
  final String lol;
  const ImageProvider(
    this.lol, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
        imageUrl: lol,
      );
    } on SocketException {
      return const Icon(Icons.error);
    }
  }
}
