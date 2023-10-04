import 'dart:convert';
import 'package:dio/dio.dart';

class DioServices {
  final Dio _dio = Dio();

  DioServices() {
    // _dio.options.followRedirects = false;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      // 'Accept': '*/*',
      'Accept': 'application/json',
    };
    _dio.options.validateStatus = (val) => true;
    /*_dio.options.connectTimeout = 10000; //5s
    _dio.options.receiveTimeout = 10000;*/

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // options.baseUrl = "https://graphqlzero.almansi.me/api";
        options.headers.addAll({
          'Content-Type': 'application/json',
          // 'Accept': '*/*',
          'Accept': 'application/json',
        });
        return handler.next(options);
      },
      onResponse: (e, handler) {
        if (e.statusCode == 401) {}
        return handler.next(e);
      },
      onError: (e, handler) {},
    ));
  }

  Dio get dio => _dio;
}

DioServices get ds => DioServices();
