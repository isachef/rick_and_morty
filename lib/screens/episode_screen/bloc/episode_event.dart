part of 'episode_bloc.dart';

@immutable
abstract class EpisodeEvent {}

class GetEpisodesEvent extends EpisodeEvent {
  final String page;

  GetEpisodesEvent(this.page);
}

class GetEpisodeEvent extends EpisodeEvent {
  final String id;

  GetEpisodeEvent(this.id);
}
