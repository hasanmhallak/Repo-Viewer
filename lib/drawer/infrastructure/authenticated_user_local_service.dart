import 'package:sembast/sembast.dart';

import '../../core/infrastructure/sembast_database.dart';
import 'authenticated_user_dto.dart';

class AuthenticatedUserLocalService {
  final SembastDatabase _database;
  AuthenticatedUserLocalService(this._database);
  static const String _key = 'currentUser';

  final _store = stringMapStoreFactory.store('authenticatedUser');

  Future<void> upsertUser(AuthenticatedUserDTO user) async {
    await _store.record(_key).put(_database.instance, user.toJson());
  }

  Future<AuthenticatedUserDTO?> getUser() async {
    final record = await _store.record(_key).get(_database.instance);
    if (record != null) {
      return AuthenticatedUserDTO.fromJson(record);
    } else {
      return null;
    }
  }

  Future<void> deleteUser() async {
    await _store.record(_key).delete(_database.instance);
  }
}
