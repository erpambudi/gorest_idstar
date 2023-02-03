import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/base/base_controller.dart';
import '../../../data/models/user_data.dart';
import '../../../data/repositories/user_repository.dart';

part 'user_manage_event.dart';
part 'user_manage_state.dart';

class UserManageBloc extends Bloc<UserManageEvent, UserManageState>
    with BaseController {
  final UserRepository _userRepository;

  UserManageBloc(this._userRepository) : super(UserManageInitial()) {
    // Add User
    on<AddUserEvent>((event, emit) async {
      emit(UserManageLoading());

      await callDataService(
        _userRepository.addUser(event.userData),
        onSuccess: (data) {
          emit(UserManageSuccess(
            message: "Berhasil menambahkan pengguna",
            user: data,
          ));
        },
        onError: (e) {
          emit(UserManageError(e));
        },
      );
    });

    // Update User
    on<UpdateUserEvent>((event, emit) async {
      emit(UserManageLoading());

      await callDataService(
        _userRepository.updateUser(event.userData),
        onSuccess: (data) {
          emit(UserManageSuccess(
            message: "Berhasil memperbaharui pengguna",
            user: data,
          ));
        },
        onError: (e) {
          emit(UserManageError(e));
        },
      );
    });

    // Delete User
    on<DeleteUserEvent>((event, emit) async {
      emit(UserManageLoading());

      await callDataService(
        _userRepository.deleteUser(event.id),
        onSuccess: (data) {
          emit(const UserManageSuccess(
            message: "Berhasil menghapus pengguna",
          ));
        },
        onError: (e) {
          emit(UserManageError(e));
        },
      );
    });
  }
}
