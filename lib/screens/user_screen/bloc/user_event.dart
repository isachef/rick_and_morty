part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserEvent extends UserEvent {
  final String id;

  GetUserEvent(this.id);
}

class GetUsersEvent extends UserEvent {}

class GetFilterUsersEvent extends UserEvent {
  final String search;

  GetFilterUsersEvent(this.search);
}
