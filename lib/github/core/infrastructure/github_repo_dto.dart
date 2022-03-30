import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/github_repo.dart';
import 'user_dto.dart';

part 'github_repo_dto.freezed.dart';
part 'github_repo_dto.g.dart';

String _descriptionFromJson(Object? json) {
  return (json as String?) ?? '';
}

@freezed
class GithubRepoDTO with _$GithubRepoDTO {
  const GithubRepoDTO._();
  const factory GithubRepoDTO({
    required int id,
    required UserDTO owner,
    required String name,
    // we don't want to make the description nullable.
    // we want to handle it here.
    // ignore: invalid_annotation_target
    @JsonKey(fromJson: _descriptionFromJson) required String description,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'stargazers_count') required int stargazerCount,
  }) = _GithubRepoDTO;

  factory GithubRepoDTO.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoDTOFromJson(json);

  factory GithubRepoDTO.fromDomain(GithubRepo _) {
    return GithubRepoDTO(
      id: _.id,
      owner: UserDTO.fromDomain(_.owner),
      name: _.name,
      description: _.description,
      stargazerCount: _.stargazerCount,
    );
  }

  GithubRepo toDoamin() {
    return GithubRepo(
      id: id,
      owner: owner.toDomain(),
      name: name,
      description: description,
      stargazerCount: stargazerCount,
    );
  }
}
