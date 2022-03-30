// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_headers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubHeadres _$$_GithubHeadresFromJson(Map<String, dynamic> json) =>
    _$_GithubHeadres(
      etag: json['etag'] as String?,
      link: json['link'] == null
          ? null
          : PaginationLink.fromJson(json['link'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GithubHeadresToJson(_$_GithubHeadres instance) =>
    <String, dynamic>{
      'etag': instance.etag,
      'link': instance.link?.toJson(),
    };

_$_PaginationLink _$$_PaginationLinkFromJson(Map<String, dynamic> json) =>
    _$_PaginationLink(
      maxPageNumber: json['maxPageNumber'] as int,
    );

Map<String, dynamic> _$$_PaginationLinkToJson(_$_PaginationLink instance) =>
    <String, dynamic>{
      'maxPageNumber': instance.maxPageNumber,
    };
