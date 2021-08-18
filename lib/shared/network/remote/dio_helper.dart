import 'package:dio/dio.dart';
import 'package:shopin/components/constant/constant.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: shopUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  /*

/////GET Data

*/

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.get(endPoint, queryParameters: query);
  }

/*

/////POST Data

*/
  static Future<Response> setData({
    required String endPoint,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.post(endPoint, queryParameters: query);
  }
}
