import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:open_id/data/secure_storage.dart';

const encoder = JsonEncoder.withIndent('  ');

class NetworkClientInterceptor extends Interceptor {
  final SecureStorageService secureStorageService;

  NetworkClientInterceptor({required this.secureStorageService});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await secureStorageService.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    } else {
      log('uncorrect access token : $accessToken');
    }

    const logtype = '\n\nREQUEST';
    final url = '\nURL: ${options.uri}';

    final headers = options.headers.map((key, value) {
      if (key.toLowerCase() == 'authorization' && value is String) {
        return MapEntry(key, 'Bearer *****');
      }
      return MapEntry(key, value);
    });

    final requestMethod = '\nREQUEST METHOD: ${options.method}';
    final body = '\nBODY: ${options.data != null ? encoder.convert(options.data as Map<String, dynamic>) : 'null'}';
    log('$logtype$url\nHEADERS: ${encoder.convert(headers)}$requestMethod$body');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    const logtype = '\n\nRESPONSE';
    final url = '\nURL: ${response.requestOptions.uri}';
    final statusCode = '\nSTATUS CODE: ${response.statusCode}';
    final headers = '\nHEADERS: ${response.headers}';
    final body = '\nBODY: ${encoder.convert(response.data as Map<String, dynamic>)}';
    log(logtype + url + statusCode + headers + body);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorType = '\nERROR TYPE: ${err.type}';
    final message = '\nMESSAGE: ${err.message}';
    final requestMethod = '\nREQUEST METHOD: ${err.requestOptions.method}';
    log(errorType + message + requestMethod);
    handler.next(err);
  }
}
