import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo_detail.freezed.dart';

@freezed
class GithubRepoDetail with _$GithubRepoDetail {
  const GithubRepoDetail._();
  const factory GithubRepoDetail({
    // we need to get the full name to preform a request.
    required String fullName,
    required String html,
    required bool isStarred,
  }) = _GithubRepoDetail;
}
