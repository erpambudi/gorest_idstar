import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gorest_idstar/core/base/base_controller.dart';
import 'package:gorest_idstar/data/models/user_data.dart';
import 'package:gorest_idstar/data/repositories/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> with BaseController {
  final UserRepository _userRepository;

  UsersBloc(this._userRepository) : super(UsersInitial()) {
    // Get Users
    on<GetUsersEvent>(
      (event, emit) async {
        emit(UsersLoading());
        await callDataService(
          _userRepository.getUsers(
            event.page,
            event.perPage,
            queryName: event.queryName,
          ),
          onSuccess: (data) {
            emit(UsersHasData(data, event.page));
          },
          onError: (e) {
            emit(UsersError(e));
          },
        );
      },
    );
  }
}
