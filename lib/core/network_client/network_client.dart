import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio;

  NetworkClient({
    required String baseUrl,
    required Dio dio,
    required Interceptor interceptor,
  }) : _dio = dio {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = const Duration(seconds: 3)
      ..receiveTimeout = const Duration(seconds: 3);

    dio.interceptors.add(interceptor);
  }

  Future<Response> get({required String endpoint, required Map<String, dynamic>? queryParameters}) {
    return _dio.get(endpoint, queryParameters: queryParameters);
  }

  Future<Response> post({required String endpoint, Object? data, Options? options}) {
    return _dio.post(endpoint, data: data, options: options);
  }

  Future<Response> patch({required String endpoint, Object? data}) {
    return _dio.patch(endpoint, data: data);
  }

  Future<Response> delete({required String endpoint, Object? data}) {
    return _dio.delete(endpoint, data: data);
  }
}
