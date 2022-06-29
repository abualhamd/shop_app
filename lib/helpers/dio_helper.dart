import 'package:dio/dio.dart';

class DioHelper {
  static late Dio _dio;
  static String baseURL = 'https://student.valuxapps.com/api/';

  static init() {
    _dio = Dio(
      BaseOptions(baseUrl: baseURL, receiveDataWhenStatusError: true, headers: {
        'Content-Type': 'application/json',
      }),
    );
  }

  static Future<Response<dynamic>> getDataOfCategory({
    required Map<String, dynamic> query,
    required String url,
    String lang = 'ar',
    String? token,
  }) async {
    _dio.options.headers = {
      "lang": lang,
      "Authorization": token,
    };

    // Map<String, dynamic> queryParams = {};
    // queryParams.addAll(query);
    return await _dio.get(url, queryParameters: query);//Params
  }

  static Future<Response<dynamic>> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    _dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return await _dio.post(url, data: data, queryParameters: query);
  }
}
