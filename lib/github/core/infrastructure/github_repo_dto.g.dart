// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubRepoDTO _$$_GithubRepoDTOFromJson(Map<String, dynamic> json) =>
    _$_GithubRepoDTO(
      id: json['id'] as int,
      owner: UserDTO.fromJson(json['owner'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: _descriptionFromJson(json['description']),
      stargazerCount: json['stargazers_count'] as int,
    );

Map<String, dynamic> _$$_GithubRepoDTOToJson(_$_GithubRepoDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner.toJson(),
      'name': instance.name,
      'description': instance.description,
      'stargazers_count': instance.stargazerCount,
    };
