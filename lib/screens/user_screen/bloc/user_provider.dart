
import 'package:dio/dio.dart';
import 'package:rick_and_morty/helpers/api_requester.dart';
import 'package:rick_and_morty/helpers/catch_exception.dart';
import 'package:rick_and_morty/models/user_model.dart';

class Provider {
  ApiRequester apiRequester = ApiRequester();

  Future<List<UserModel>> getUsers() async {
    late List<UserModel> userModelList;
    try {
      Response response = await apiRequester.toGet("/character",{});

      if (response.statusCode == 200) {
        List<dynamic> a = response.data["results"];
        userModelList = a.map<UserModel>((el) {
          return UserModel.fromJson(el);
        }).toList();

        return userModelList;
      } else {
        throw CatchException.convertException(response.statusCode);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }

  Future<UserModel> getUser(String id) async {
    try {
      Response response = await apiRequester.toGet("/character/$id",{});

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw CatchException.convertException(response.statusCode);
      }
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
