import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/domain/fresh.dart';
import '../domain/authenticated_user.dart';
import '../infrastructure/authenticated_user_repository.dart';
import '../../github/core/domain/github_failure.dart';

part 'authenticated_user_notifier.freezed.dart';

@freezed
class AuthenticatedUserState with _$AuthenticatedUserState {
  const AuthenticatedUserState._();
  const factory AuthenticatedUserState.initial() = _Initial;
  const factory AuthenticatedUserState.loadSuccess(
    Fresh<AuthenticatedUser?> authUser,
  ) = _LoadSuccess;
  const factory AuthenticatedUserState.loadFailure(GithubFailure failure) =
      _LoadFailure;
}

class AuthenticatedUserNotifier extends StateNotifier<AuthenticatedUserState> {
  final AuthenticatedUserRepository _repository;
  AuthenticatedUserNotifier(this._repository)
      : super(const AuthenticatedUserState.initial());

  Future<void> getUserInfo() async {
    final failureOrSuccess = await _repository.getUser();
    state = failureOrSuccess.fold(
      (failure) => AuthenticatedUserState.loadFailure(failure),
      (fresh) => AuthenticatedUserState.loadSuccess(fresh),
    );
  }
}
