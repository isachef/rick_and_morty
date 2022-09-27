import 'package:dio/dio.dart';
import 'package:rick_and_morty/helpers/api_requester.dart';
import 'package:rick_and_morty/helpers/catch_exception.dart';
import 'package:rick_and_morty/models/location_model.dart';

class Provider {
  ApiRequester apiRequester = ApiRequester();

  Future<List<LocationModel>> getLocations() async {
    try {
      Response response = await apiRequester.toGet("/location", {});
      if (response.statusCode == 200) {
        return response.data['results']
            .map<LocationModel>((el) => LocationModel.fromJson(el))
            .toList();
      } else {
        throw CatchException.convertException(response.statusCode);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<LocationModel> getLocation(String id) async {
    Response response = await apiRequester.toGet("/location/$id", {});

    try {
      if (response.statusCode == 200) {
        return LocationModel.fromJson(response.data);
      } else {
        throw CatchException.convertException(response.statusCode);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
