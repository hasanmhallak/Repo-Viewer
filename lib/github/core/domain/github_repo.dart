import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';

import 'user.dart';

part 'github_repo.freezed.dart';

@freezed
class GithubRepo with _$GithubRepo {
  const GithubRepo._();
  const factory GithubRepo({
    required int id,
    required User owner,
    required String name,
    required String description,
    required int stargazerCount,
  }) = _GithubRepo;

  String get fullName => '${owner.name}/$name';
}
