import 'package:dio/dio.dart';
import 'package:rick_and_morty/helpers/api_requester.dart';
import 'package:rick_and_morty/helpers/catch_exception.dart';
import 'package:rick_and_morty/models/episode_model.dart';

class EpisodeProvider {
  ApiRequester apiRequester = ApiRequester();

  Future<List<EpisodeModel>> getEpisodes(String page) async {
    try {
      Response response = await apiRequester.toGet("/episode", {'page': page});
      if (response.statusCode == 200) {
        return response.data['results']
            .map<EpisodeModel>((el) => EpisodeModel.fromJson(el))
            .toList();
      } else {
        throw CatchException.convertException(response.statusCode);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<EpisodeModel> getEpisode(String id) async {
    try {
      Response response = await apiRequester.toGet("/episode/$id", {});
      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(response.data);
      } else {
        throw CatchException.convertException(response.statusCode);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
