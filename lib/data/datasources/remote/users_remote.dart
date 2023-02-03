import '../../../core/base/base_remote_source.dart';
import '../../../core/network/handlers/dio_provider.dart';
import '../../models/user_data.dart';

abstract class UsersRemote {
  Future<List<UserData>> getUsers(int page, int perPage, {String? queryName});
  Future<UserData> getDetailUsers(int id);
  Future<UserData> addUser(UserData userData);
  Future<UserData> updateUser(UserData userData);
  Future<void> deleteUser(int id);
}

class UsersRemoteImpl extends BaseRemoteSource implements UsersRemote {
  @override
  Future<List<UserData>> getUsers(int page, int perPage, {String? queryName}) {
    var query =
        queryName != null && queryName.isNotEmpty ? "&name=$queryName" : "";

    var endpoint =
        "${DioProvider.baseUrl}/users?page=$page&per_page=$perPage$query";
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall).then((response) {
        List data = response.data;

        final result =
            List<UserData>.from(data.map((e) => UserData.fromJson(e)));

        return result;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserData> getDetailUsers(int id) {
    var endpoint = "${DioProvider.baseUrl}/users/$id}";
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => UserData.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserData> addUser(UserData userData) {
    var endpoint = "${DioProvider.baseUrl}/users";

    var dioCall = dioClient.post(endpoint, data: userData.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => UserData.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserData> updateUser(UserData userData) {
    var endpoint = "${DioProvider.baseUrl}/users/${userData.id}";

    var dioCall = dioClient.put(endpoint, data: userData.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => UserData.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(int id) {
    var endpoint = "${DioProvider.baseUrl}/users/$id";

    var dioCall = dioClient.delete(endpoint);

    try {
      return callApiWithErrorParser(dioCall);
    } catch (e) {
      rethrow;
    }
  }
}
