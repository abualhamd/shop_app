import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;
  static const String _baseURL = 'https://student.valuxapps.com/api/';

  static init() {
    _dio = Dio(
      BaseOptions(
          baseUrl: _baseURL,
          receiveDataWhenStatusError: true,
          //TODO remove headers from here and move it to the below methods
          headers: {
            'Content-Type': 'application/json',
          }),
    );
  }

  static Future<Response<dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) async {
    _dio.options.headers = {
      "lang": lang,
      "Authorization": token,
    };

    return await _dio.get(endPoint, queryParameters: query); //Params
  }

  static Future<Response<dynamic>> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    _dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await _dio.post(url, data: data, queryParameters: query);
  }
}
