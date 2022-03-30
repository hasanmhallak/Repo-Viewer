import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/shared/providers.dart';
import '../application/authenticated_user_notifier.dart';
import '../infrastructure/authenticated_user_local_service.dart';
import '../infrastructure/authenticated_user_remote_service.dart';
import '../infrastructure/authenticated_user_repository.dart';
import '../../github/core/shared/providers.dart';

final authUserRemoteServiceProvider = Provider(
  (ref) => AuthenticatedUserRemoteService(
    ref.watch(dioForRepo),
    ref.watch(githubHeadersCacheProvider),
  ),
);

final authUserLocalServiceProvider = Provider(
  (ref) => AuthenticatedUserLocalService(
    ref.watch(sembastProvider),
  ),
);

final authUserRepository = Provider(
  (ref) => AuthenticatedUserRepository(
    ref.watch(authUserRemoteServiceProvider),
    ref.watch(authUserLocalServiceProvider),
    ref.watch(starredRepoLocalServiceProvider),
  ),
);

final authUserNotifierProvider =
    StateNotifierProvider<AuthenticatedUserNotifier, AuthenticatedUserState>(
  (ref) => AuthenticatedUserNotifier(
    ref.watch(authUserRepository),
  ),
);
