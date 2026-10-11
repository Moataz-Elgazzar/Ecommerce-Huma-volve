import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/services/dio_endpoint.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioProvider {
  static late Dio dio;

  // Initialize Dio instance
  static void init() {
    dio = Dio(BaseOptions(baseUrl: DioEndpoint.baseUrl, connectTimeout: const Duration(seconds: 3), receiveTimeout: const Duration(seconds: 3), headers: {'ContentType': 'application/json', 'Accept': 'application/json'}));

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
    ));
  }

  // Post request
  static Future<Response> post({required String path, Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  // Get request
  static Future<Response> get({required String path, Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    return await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  // Put request
  static Future<Response> put({required String path, Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  // Patch request
  static Future<Response> patch({required String path, Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    return await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  // Delete request
  static Future<Response> delete({required String path, Object? data, Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    return await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
