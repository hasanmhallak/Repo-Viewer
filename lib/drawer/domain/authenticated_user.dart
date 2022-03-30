import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/drawer/infrastructure/authenticated_user_dto.dart';

part 'authenticated_user.freezed.dart';

@freezed
class AuthenticatedUser with _$AuthenticatedUser {
  const AuthenticatedUser._();
  const factory AuthenticatedUser({
    required String userName,
    required String name,
    required int followers,
    required int following,
    required String avatar,
    required int starredRepos,
  }) = _AuthenticatedUser;

  String get avatarUrlSmall => '$avatar&s=64';
  AuthenticatedUserDTO toDto() {
    return AuthenticatedUserDTO(
      userName: userName,
      name: name,
      followers: followers,
      following: following,
      avatar: avatar,
      starredRepos: starredRepos,
    );
  }
}
