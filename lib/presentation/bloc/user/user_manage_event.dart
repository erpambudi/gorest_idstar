part of 'user_manage_bloc.dart';

abstract class UserManageEvent extends Equatable {
  const UserManageEvent();

  @override
  List<Object> get props => [];
}

class AddUserEvent extends UserManageEvent {
  final UserData userData;

  const AddUserEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class UpdateUserEvent extends UserManageEvent {
  final UserData userData;

  const UpdateUserEvent(this.userData);

  @override
  List<Object> get props => [userData];
}

class DeleteUserEvent extends UserManageEvent {
  final int id;

  const DeleteUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
