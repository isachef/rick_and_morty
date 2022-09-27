import 'package:rick_and_morty/screens/episode_screen/bloc/episode_provider.dart';

import '../../../models/episode_model.dart';

class EpisodeRepository {
  EpisodeProvider episodeProvider = EpisodeProvider();

  Future<List<EpisodeModel>> getEpisodes(String page) {
  
    return episodeProvider.getEpisodes( page);
  }

  Future<EpisodeModel> getEpisode(String id) {
    return episodeProvider.getEpisode(id);
  }
}
