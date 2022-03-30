// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthenticatedUserDTO _$$_AuthenticatedUserDTOFromJson(
        Map<String, dynamic> json) =>
    _$_AuthenticatedUserDTO(
      userName: json['login'] as String,
      name: _nameFromjson(json['name']),
      followers: json['followers'] as int,
      following: json['following'] as int,
      avatar: json['avatar_url'] as String,
      starredRepos: json['starredRepos'] as int? ?? 0,
    );

Map<String, dynamic> _$$_AuthenticatedUserDTOToJson(
        _$_AuthenticatedUserDTO instance) =>
    <String, dynamic>{
      'login': instance.userName,
      'name': instance.name,
      'followers': instance.followers,
      'following': instance.following,
      'avatar_url': instance.avatar,
      'starredRepos': instance.starredRepos,
    };
