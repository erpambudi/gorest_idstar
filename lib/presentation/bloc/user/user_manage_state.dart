part of 'user_manage_bloc.dart';

abstract class UserManageState extends Equatable {
  const UserManageState();

  @override
  List<Object> get props => [];
}

class UserManageInitial extends UserManageState {}

class UserManageLoading extends UserManageState {}

class UserManageSuccess extends UserManageState {
  final UserData? user;
  final String message;

  const UserManageSuccess({required this.message, this.user});
}

class UserManageError extends UserManageState {
  final String message;

  const UserManageError(this.message);

  @override
  List<Object> get props => [message];
}
