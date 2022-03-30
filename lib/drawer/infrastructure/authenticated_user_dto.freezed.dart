// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'authenticated_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthenticatedUserDTO _$AuthenticatedUserDTOFromJson(Map<String, dynamic> json) {
  return _AuthenticatedUserDTO.fromJson(json);
}

/// @nodoc
class _$AuthenticatedUserDTOTearOff {
  const _$AuthenticatedUserDTOTearOff();

  _AuthenticatedUserDTO call(
      {@JsonKey(name: 'login') required String userName,
      @JsonKey(fromJson: _nameFromjson) required String name,
      required int followers,
      required int following,
      @JsonKey(name: 'avatar_url') required String avatar,
      int starredRepos = 0}) {
    return _AuthenticatedUserDTO(
      userName: userName,
      name: name,
      followers: followers,
      following: following,
      avatar: avatar,
      starredRepos: starredRepos,
    );
  }

  AuthenticatedUserDTO fromJson(Map<String, Object?> json) {
    return AuthenticatedUserDTO.fromJson(json);
  }
}

/// @nodoc
const $AuthenticatedUserDTO = _$AuthenticatedUserDTOTearOff();

/// @nodoc
mixin _$AuthenticatedUserDTO {
  @JsonKey(name: 'login')
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _nameFromjson)
  String get name => throw _privateConstructorUsedError;
  int get followers => throw _privateConstructorUsedError;
  int get following => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String get avatar => throw _privateConstructorUsedError;
  int get starredRepos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticatedUserDTOCopyWith<AuthenticatedUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticatedUserDTOCopyWith<$Res> {
  factory $AuthenticatedUserDTOCopyWith(AuthenticatedUserDTO value,
          $Res Function(AuthenticatedUserDTO) then) =
      _$AuthenticatedUserDTOCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'login') String userName,
      @JsonKey(fromJson: _nameFromjson) String name,
      int followers,
      int following,
      @JsonKey(name: 'avatar_url') String avatar,
      int starredRepos});
}

/// @nodoc
class _$AuthenticatedUserDTOCopyWithImpl<$Res>
    implements $AuthenticatedUserDTOCopyWith<$Res> {
  _$AuthenticatedUserDTOCopyWithImpl(this._value, this._then);

  final AuthenticatedUserDTO _value;
  // ignore: unused_field
  final $Res Function(AuthenticatedUserDTO) _then;

  @override
  $Res call({
    Object? userName = freezed,
    Object? name = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? avatar = freezed,
    Object? starredRepos = freezed,
  }) {
    return _then(_value.copyWith(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      followers: followers == freezed
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as int,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      starredRepos: starredRepos == freezed
          ? _value.starredRepos
          : starredRepos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AuthenticatedUserDTOCopyWith<$Res>
    implements $AuthenticatedUserDTOCopyWith<$Res> {
  factory _$AuthenticatedUserDTOCopyWith(_AuthenticatedUserDTO value,
          $Res Function(_AuthenticatedUserDTO) then) =
      __$AuthenticatedUserDTOCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'login') String userName,
      @JsonKey(fromJson: _nameFromjson) String name,
      int followers,
      int following,
      @JsonKey(name: 'avatar_url') String avatar,
      int starredRepos});
}

/// @nodoc
class __$AuthenticatedUserDTOCopyWithImpl<$Res>
    extends _$AuthenticatedUserDTOCopyWithImpl<$Res>
    implements _$AuthenticatedUserDTOCopyWith<$Res> {
  __$AuthenticatedUserDTOCopyWithImpl(
      _AuthenticatedUserDTO _value, $Res Function(_AuthenticatedUserDTO) _then)
      : super(_value, (v) => _then(v as _AuthenticatedUserDTO));

  @override
  _AuthenticatedUserDTO get _value => super._value as _AuthenticatedUserDTO;

  @override
  $Res call({
    Object? userName = freezed,
    Object? name = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? avatar = freezed,
    Object? starredRepos = freezed,
  }) {
    return _then(_AuthenticatedUserDTO(
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      followers: followers == freezed
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as int,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as int,
      avatar: avatar == freezed
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      starredRepos: starredRepos == freezed
          ? _value.starredRepos
          : starredRepos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthenticatedUserDTO extends _AuthenticatedUserDTO {
  const _$_AuthenticatedUserDTO(
      {@JsonKey(name: 'login') required this.userName,
      @JsonKey(fromJson: _nameFromjson) required this.name,
      required this.followers,
      required this.following,
      @JsonKey(name: 'avatar_url') required this.avatar,
      this.starredRepos = 0})
      : super._();

  factory _$_AuthenticatedUserDTO.fromJson(Map<String, dynamic> json) =>
      _$$_AuthenticatedUserDTOFromJson(json);

  @override
  @JsonKey(name: 'login')
  final String userName;
  @override
  @JsonKey(fromJson: _nameFromjson)
  final String name;
  @override
  final int followers;
  @override
  final int following;
  @override
  @JsonKey(name: 'avatar_url')
  final String avatar;
  @JsonKey()
  @override
  final int starredRepos;

  @override
  String toString() {
    return 'AuthenticatedUserDTO(userName: $userName, name: $name, followers: $followers, following: $following, avatar: $avatar, starredRepos: $starredRepos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticatedUserDTO &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.followers, followers) &&
            const DeepCollectionEquality().equals(other.following, following) &&
            const DeepCollectionEquality().equals(other.avatar, avatar) &&
            const DeepCollectionEquality()
                .equals(other.starredRepos, starredRepos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(followers),
      const DeepCollectionEquality().hash(following),
      const DeepCollectionEquality().hash(avatar),
      const DeepCollectionEquality().hash(starredRepos));

  @JsonKey(ignore: true)
  @override
  _$AuthenticatedUserDTOCopyWith<_AuthenticatedUserDTO> get copyWith =>
      __$AuthenticatedUserDTOCopyWithImpl<_AuthenticatedUserDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthenticatedUserDTOToJson(this);
  }
}

abstract class _AuthenticatedUserDTO extends AuthenticatedUserDTO {
  const factory _AuthenticatedUserDTO(
      {@JsonKey(name: 'login') required String userName,
      @JsonKey(fromJson: _nameFromjson) required String name,
      required int followers,
      required int following,
      @JsonKey(name: 'avatar_url') required String avatar,
      int starredRepos}) = _$_AuthenticatedUserDTO;
  const _AuthenticatedUserDTO._() : super._();

  factory _AuthenticatedUserDTO.fromJson(Map<String, dynamic> json) =
      _$_AuthenticatedUserDTO.fromJson;

  @override
  @JsonKey(name: 'login')
  String get userName;
  @override
  @JsonKey(fromJson: _nameFromjson)
  String get name;
  @override
  int get followers;
  @override
  int get following;
  @override
  @JsonKey(name: 'avatar_url')
  String get avatar;
  @override
  int get starredRepos;
  @override
  @JsonKey(ignore: true)
  _$AuthenticatedUserDTOCopyWith<_AuthenticatedUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}
