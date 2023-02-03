part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent {
  final int page;
  final int perPage;
  final String? queryName;

  const GetUsersEvent(this.page, this.perPage, {this.queryName});

  @override
  List<Object> get props => [page, perPage];
}
