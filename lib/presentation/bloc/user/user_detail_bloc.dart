import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gorest_idstar/core/base/base_controller.dart';
import 'package:gorest_idstar/data/models/user_data.dart';

import '../../../data/repositories/user_repository.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState>
    with BaseController {
  final UserRepository _userRepository;

  UserDetailBloc(this._userRepository) : super(UserDetailInitial()) {
    // Get Detail User
    on<GetDetailUserEvent>((event, emit) async {
      emit(UserDetailLoading());

      await callDataService(
        _userRepository.getDetailUsers(event.id),
        onSuccess: (data) {
          emit(UserDetailHasData(data));
        },
        onError: (e) {
          emit(UserDetailError(e));
        },
      );
    });
  }
}
