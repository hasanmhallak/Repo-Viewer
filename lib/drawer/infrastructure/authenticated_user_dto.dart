// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/drawer/domain/authenticated_user.dart';

part 'authenticated_user_dto.freezed.dart';
part 'authenticated_user_dto.g.dart';

// Handles null.
String _nameFromjson(Object? json) {
  final name = json as String?;
  if (name == null || name.isEmpty) {
    return '-';
  } else {
    return name;
  }
}

@freezed
class AuthenticatedUserDTO with _$AuthenticatedUserDTO {
  const AuthenticatedUserDTO._();
  const factory AuthenticatedUserDTO({
    @JsonKey(name: 'login') required String userName,
    @JsonKey(fromJson: _nameFromjson) required String name,
    required int followers,
    required int following,
    @JsonKey(name: 'avatar_url') required String avatar,
    @Default(0) int starredRepos,
  }) = _AuthenticatedUserDTO;

  factory AuthenticatedUserDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserDTOFromJson(json);

  AuthenticatedUser toDoamin() {
    return AuthenticatedUser(
      userName: userName,
      name: name,
      followers: followers,
      following: following,
      avatar: avatar,
      starredRepos: starredRepos,
    );
  }
}
