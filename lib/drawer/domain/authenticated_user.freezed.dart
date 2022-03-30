// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'authenticated_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthenticatedUserTearOff {
  const _$AuthenticatedUserTearOff();

  _AuthenticatedUser call(
      {required String userName,
      required String name,
      required int followers,
      required int following,
      required String avatar,
      required int starredRepos}) {
    return _AuthenticatedUser(
      userName: userName,
      name: name,
      followers: followers,
      following: following,
      avatar: avatar,
      starredRepos: starredRepos,
    );
  }
}

/// @nodoc
const $AuthenticatedUser = _$AuthenticatedUserTearOff();

/// @nodoc
mixin _$AuthenticatedUser {
  String get userName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get followers => throw _privateConstructorUsedError;
  int get following => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  int get starredRepos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthenticatedUserCopyWith<AuthenticatedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticatedUserCopyWith<$Res> {
  factory $AuthenticatedUserCopyWith(
          AuthenticatedUser value, $Res Function(AuthenticatedUser) then) =
      _$AuthenticatedUserCopyWithImpl<$Res>;
  $Res call(
      {String userName,
      String name,
      int followers,
      int following,
      String avatar,
      int starredRepos});
}

/// @nodoc
class _$AuthenticatedUserCopyWithImpl<$Res>
    implements $AuthenticatedUserCopyWith<$Res> {
  _$AuthenticatedUserCopyWithImpl(this._value, this._then);

  final AuthenticatedUser _value;
  // ignore: unused_field
  final $Res Function(AuthenticatedUser) _then;

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
abstract class _$AuthenticatedUserCopyWith<$Res>
    implements $AuthenticatedUserCopyWith<$Res> {
  factory _$AuthenticatedUserCopyWith(
          _AuthenticatedUser value, $Res Function(_AuthenticatedUser) then) =
      __$AuthenticatedUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String userName,
      String name,
      int followers,
      int following,
      String avatar,
      int starredRepos});
}

/// @nodoc
class __$AuthenticatedUserCopyWithImpl<$Res>
    extends _$AuthenticatedUserCopyWithImpl<$Res>
    implements _$AuthenticatedUserCopyWith<$Res> {
  __$AuthenticatedUserCopyWithImpl(
      _AuthenticatedUser _value, $Res Function(_AuthenticatedUser) _then)
      : super(_value, (v) => _then(v as _AuthenticatedUser));

  @override
  _AuthenticatedUser get _value => super._value as _AuthenticatedUser;

  @override
  $Res call({
    Object? userName = freezed,
    Object? name = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? avatar = freezed,
    Object? starredRepos = freezed,
  }) {
    return _then(_AuthenticatedUser(
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

class _$_AuthenticatedUser extends _AuthenticatedUser {
  const _$_AuthenticatedUser(
      {required this.userName,
      required this.name,
      required this.followers,
      required this.following,
      required this.avatar,
      required this.starredRepos})
      : super._();

  @override
  final String userName;
  @override
  final String name;
  @override
  final int followers;
  @override
  final int following;
  @override
  final String avatar;
  @override
  final int starredRepos;

  @override
  String toString() {
    return 'AuthenticatedUser(userName: $userName, name: $name, followers: $followers, following: $following, avatar: $avatar, starredRepos: $starredRepos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticatedUser &&
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
  _$AuthenticatedUserCopyWith<_AuthenticatedUser> get copyWith =>
      __$AuthenticatedUserCopyWithImpl<_AuthenticatedUser>(this, _$identity);
}

abstract class _AuthenticatedUser extends AuthenticatedUser {
  const factory _AuthenticatedUser(
      {required String userName,
      required String name,
      required int followers,
      required int following,
      required String avatar,
      required int starredRepos}) = _$_AuthenticatedUser;
  const _AuthenticatedUser._() : super._();

  @override
  String get userName;
  @override
  String get name;
  @override
  int get followers;
  @override
  int get following;
  @override
  String get avatar;
  @override
  int get starredRepos;
  @override
  @JsonKey(ignore: true)
  _$AuthenticatedUserCopyWith<_AuthenticatedUser> get copyWith =>
      throw _privateConstructorUsedError;
}
