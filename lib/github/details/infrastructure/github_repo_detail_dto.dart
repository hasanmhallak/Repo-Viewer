import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/timestamp.dart';

import '../domain/github_repo_detail.dart';

part 'github_repo_detail_dto.freezed.dart';
part 'github_repo_detail_dto.g.dart';

@freezed
class GithubRepoDetailDTO with _$GithubRepoDetailDTO {
  const GithubRepoDetailDTO._();
  const factory GithubRepoDetailDTO({
    // we need to get the full name to preform a request.
    required String fullName,
    required String html,
    required bool isStarred,
  }) = _GithubRepoDetailDTO;

  factory GithubRepoDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoDetailDTOFromJson(json);

  GithubRepoDetail toDomain() => GithubRepoDetail(
        fullName: fullName,
        html: html,
        isStarred: isStarred,
      );

  static const lastUsedFieldName = 'lastUsed';

  /// Remove the `fullName` argument as it will be present as the key of each record.
  Map<String, dynamic> toSembast() {
    final json = toJson();
    json.remove('fullName');
    // to now the most recent readme, in order to sort them properly.
    json[lastUsedFieldName] = Timestamp.now();

    return json;
  }

  factory GithubRepoDetailDTO.fromSembast(
    RecordSnapshot<String, Map<String, dynamic>> snapshot,
  ) {
    // Sembast will return an unmodifiable map.
    final copiedMap = Map<String, dynamic>.from(snapshot.value);
    copiedMap['fullName'] = snapshot.key;

    return GithubRepoDetailDTO.fromJson(copiedMap);
  }
}
