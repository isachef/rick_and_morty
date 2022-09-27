part of 'episode_bloc.dart';

@immutable
abstract class EpisodeState {}

class EpisodeInitial extends EpisodeState {}

class EpisodesFetchedState extends EpisodeState {
  final List<EpisodeModel> episodeModelList;

  EpisodesFetchedState(this.episodeModelList);
}

class EpisodeFetchedState extends EpisodeState {
  final EpisodeModel episodeModel;
  final List<UserModel> userModelList;
  EpisodeFetchedState({required this.episodeModel, required this.userModelList});
}

class EpisodeLoadingState extends EpisodeState {}

class EpisodeErrorState extends EpisodeState {
  final CatchException error;

  EpisodeErrorState(this.error);
}
