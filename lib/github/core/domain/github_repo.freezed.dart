// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'github_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GithubRepoTearOff {
  const _$GithubRepoTearOff();

  _GithubRepo call(
      {required int id,
      required User owner,
      required String name,
      required String description,
      required int stargazerCount}) {
    return _GithubRepo(
      id: id,
      owner: owner,
      name: name,
      description: description,
      stargazerCount: stargazerCount,
    );
  }
}

/// @nodoc
const $GithubRepo = _$GithubRepoTearOff();

/// @nodoc
mixin _$GithubRepo {
  int get id => throw _privateConstructorUsedError;
  User get owner => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get stargazerCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubRepoCopyWith<GithubRepo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepoCopyWith<$Res> {
  factory $GithubRepoCopyWith(
          GithubRepo value, $Res Function(GithubRepo) then) =
      _$GithubRepoCopyWithImpl<$Res>;
  $Res call(
      {int id,
      User owner,
      String name,
      String description,
      int stargazerCount});

  $UserCopyWith<$Res> get owner;
}

/// @nodoc
class _$GithubRepoCopyWithImpl<$Res> implements $GithubRepoCopyWith<$Res> {
  _$GithubRepoCopyWithImpl(this._value, this._then);

  final GithubRepo _value;
  // ignore: unused_field
  final $Res Function(GithubRepo) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? owner = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? stargazerCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as User,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      stargazerCount: stargazerCount == freezed
          ? _value.stargazerCount
          : stargazerCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $UserCopyWith<$Res> get owner {
    return $UserCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value));
    });
  }
}

/// @nodoc
abstract class _$GithubRepoCopyWith<$Res> implements $GithubRepoCopyWith<$Res> {
  factory _$GithubRepoCopyWith(
          _GithubRepo value, $Res Function(_GithubRepo) then) =
      __$GithubRepoCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      User owner,
      String name,
      String description,
      int stargazerCount});

  @override
  $UserCopyWith<$Res> get owner;
}

/// @nodoc
class __$GithubRepoCopyWithImpl<$Res> extends _$GithubRepoCopyWithImpl<$Res>
    implements _$GithubRepoCopyWith<$Res> {
  __$GithubRepoCopyWithImpl(
      _GithubRepo _value, $Res Function(_GithubRepo) _then)
      : super(_value, (v) => _then(v as _GithubRepo));

  @override
  _GithubRepo get _value => super._value as _GithubRepo;

  @override
  $Res call({
    Object? id = freezed,
    Object? owner = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? stargazerCount = freezed,
  }) {
    return _then(_GithubRepo(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      owner: owner == freezed
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as User,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      stargazerCount: stargazerCount == freezed
          ? _value.stargazerCount
          : stargazerCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_GithubRepo extends _GithubRepo {
  const _$_GithubRepo(
      {required this.id,
      required this.owner,
      required this.name,
      required this.description,
      required this.stargazerCount})
      : super._();

  @override
  final int id;
  @override
  final User owner;
  @override
  final String name;
  @override
  final String description;
  @override
  final int stargazerCount;

  @override
  String toString() {
    return 'GithubRepo(id: $id, owner: $owner, name: $name, description: $description, stargazerCount: $stargazerCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GithubRepo &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.owner, owner) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.stargazerCount, stargazerCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(owner),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(stargazerCount));

  @JsonKey(ignore: true)
  @override
  _$GithubRepoCopyWith<_GithubRepo> get copyWith =>
      __$GithubRepoCopyWithImpl<_GithubRepo>(this, _$identity);
}

abstract class _GithubRepo extends GithubRepo {
  const factory _GithubRepo(
      {required int id,
      required User owner,
      required String name,
      required String description,
      required int stargazerCount}) = _$_GithubRepo;
  const _GithubRepo._() : super._();

  @override
  int get id;
  @override
  User get owner;
  @override
  String get name;
  @override
  String get description;
  @override
  int get stargazerCount;
  @override
  @JsonKey(ignore: true)
  _$GithubRepoCopyWith<_GithubRepo> get copyWith =>
      throw _privateConstructorUsedError;
}
