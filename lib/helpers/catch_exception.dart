import 'dart:developer';

import 'package:dio/dio.dart';

class CatchException {
  String? message;
  CatchException({this.message});
  static CatchException convertException(dynamic error) {
    if (error is DioError && error.error is CatchException) {
      return error.error;
    }
    if (error is DioError) {
      print(error);
      if (error.type == DioErrorType.connectTimeout) {
        print('CONNECTION_ERROR');
        return CatchException(
            message: 'Превышено время обработки запроса. Повторите позднее');
      } else if (error.type == DioErrorType.receiveTimeout) {
        print('RECIVE_ERROR');
        return CatchException(
            message: 'Превышено время обработки запроса. Повторите позднее');
      } else if (error.response == null) {
        print('NO_INTERNET');
        return CatchException(message: 'Нет интернет соеденения');
      } else if (error.response!.statusCode == 401) {
        print('401 - AUTH ERROR');
        return CatchException(message: 'Ошибка обновления токена');
      } else if (error.response!.statusCode == 409) {
        return CatchException(message: error.response!.data["message"]);
      } else if (error.response!.statusCode == 404) {
        return CatchException(message: 'этой информации нет');
      } else {
        return CatchException(message: 'Произошла системаная ошибка');
      }
    }
   
    if (error is CatchException) {
      return error;
    } else {
      log('111');
      return CatchException(message: 'Произошла системаная ошибка');
    }
  }
}
