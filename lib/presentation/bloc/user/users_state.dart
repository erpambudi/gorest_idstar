part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersHasData extends UsersState {
  final int currentPage;
  final List<UserData> users;

  const UsersHasData(this.users, this.currentPage);

  @override
  List<Object> get props => [users, currentPage];
}

class UsersError extends UsersState {
  final String message;

  const UsersError(this.message);

  @override
  List<Object> get props => [message];
}
