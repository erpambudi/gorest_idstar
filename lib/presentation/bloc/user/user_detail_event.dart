part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailUserEvent extends UserDetailEvent {
  final int id;

  const GetDetailUserEvent(this.id);

  @override
  List<Object> get props => [id];
}
