import '../datasources/remote/users_remote.dart';
import '../models/user_data.dart';

abstract class UserRepository {
  Future<List<UserData>> getUsers(int page, int perPage, {String? queryName});
  Future<UserData> getDetailUsers(int id);
  Future<UserData> addUser(UserData userData);
  Future<UserData> updateUser(UserData userData);
  Future<void> deleteUser(int id);
}

class UserRepositoryImpl implements UserRepository {
  final UsersRemote usersServices;

  UserRepositoryImpl(this.usersServices);

  @override
  Future<List<UserData>> getUsers(int page, int perPage,
      {String? queryName}) async {
    return usersServices.getUsers(page, perPage, queryName: queryName);
  }

  @override
  Future<UserData> getDetailUsers(int id) async {
    return usersServices.getDetailUsers(id);
  }

  @override
  Future<UserData> addUser(UserData userData) {
    return usersServices.addUser(userData);
  }

  @override
  Future<UserData> updateUser(UserData userData) {
    return usersServices.updateUser(userData);
  }

  @override
  Future<void> deleteUser(int id) {
    return usersServices.deleteUser(id);
  }
}
