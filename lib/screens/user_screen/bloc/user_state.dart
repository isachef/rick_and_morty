part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UsersFetchedState extends UserState {
  final List<UserModel> userModelList;

  UsersFetchedState(this.userModelList);
}

class UserFetchedState extends UserState {
  final UserModel userModel;
  final List<EpisodeModel> episodeModel;

  UserFetchedState({required this.userModel, required this.episodeModel});
}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final CatchException error;

  UserErrorState(this.error);
}
