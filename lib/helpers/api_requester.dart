import 'package:dio/dio.dart';
import 'package:rick_and_morty/helpers/catch_exception.dart';

class ApiRequester {
  static String url = "https://rickandmortyapi.com/api";

  Dio initDio() {
    return Dio(
      BaseOptions(
          baseUrl: url,
          connectTimeout: 10000,
          receiveTimeout: 10000,
          responseType: ResponseType.json,),
    );
  }

  Dio initDioSSS(String myUrl) {
    return Dio(
      BaseOptions(
          baseUrl: myUrl,
          connectTimeout: 10000,
          receiveTimeout: 10000,
          responseType: ResponseType.json,),
    );
  }

// Future<Response> toGetMy(String myUrl) {
//     Dio dio = initDioSSS(myUrl);

//     try {
//       return dio.get('');
//     } catch (e) {
//       throw CatchException.convertException(e);
//     }
//   }

  Future<Response> toGet(String path,Map<String,dynamic> ? queryParameters) {
    Dio dio = initDio();

    try {
      return dio.get(path,queryParameters: queryParameters);
    } catch (e) {
      throw CatchException.convertException(e);
    }
  }
}
