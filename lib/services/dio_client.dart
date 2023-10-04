import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'dio_services.dart';

class DioClient {
  static final instance = DioClient();

  Future<Map<String, dynamic>> postData({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = ds.dio;
    Map<String, dynamic> headers = {};
    debugPrint('headers: ${headers['Content-Type']}');
    debugPrint('data : $data');
    final response = await dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    // debugPrint('response post: ${response.statusCode}');
    // debugPrint('response post data: ${response.data}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['data'];
      // final resJson = response.data;
      // debugPrint('rr $resJson');
      // if (resJson is String) {
      //   throw 'Unauthorized request!';
      // } else {
      //   debugPrint('response json: ${resJson['statusCode']}');
      //   if (resJson['statusCode'] == 200 || resJson['statusCode'] == 201) {
      //     if (resJson.containsKey('data')) {
      //       if (resJson['data'] is List) {
      //         debugPrint('is list: ${resJson['data'].length}');
      //         final returnData = {
      //           'dataList': resJson['data'],
      //         };
      //         if (resJson.containsKey('meta')) {
      //           if (resJson['meta'].containsKey('last_page')) {
      //             returnData.putIfAbsent(
      //                 'lastPage', () => resJson['meta']['last_page']);
      //           }
      //           if (resJson['meta'].containsKey('total')) {
      //             returnData.putIfAbsent(
      //                 'total', () => resJson['meta']['total']);
      //           }
      //         }
      //         return returnData;
      //       }
      //       return resJson['data'] ?? {};
      //     } else {
      //       return resJson;
      //     }
      //   } else {
      //     throw resJson['message'];
      //   }
      // }
    } else {
      final resJson = response.data;
      debugPrint('res data out 200: $resJson');
      if (resJson != null) {
        debugPrint('res json out 200: $resJson');
        if (resJson.containsKey('message')) {
          debugPrint('res js me: : ${resJson['message']}');
          if (resJson.containsKey('data')) {
            if (resJson['data'].length >= 1) {
              debugPrint('keys erro :${resJson['data']} type: ${resJson['data'].runtimeType}');
              throw resJson['data'][resJson['data'].keys.first][0];
            }
          }
          throw resJson['message'];
        }
      }
      throw response.statusMessage ?? 'Something went wrong!';
    }
  }

  // Future<Map<String, dynamic>> getData({
  //   required String url,
  //   Map<String, dynamic>? queryParameters,
  // }) async {
  //   final dio = ds.dio;
  //   Map<String, dynamic> headers = {};
  //   Map<String, dynamic> updateQueryParameters = queryParameters == null
  //       ? {"appId": ApiUrl.appId, "appCategory": ApiUrl.appCategory}
  //       : {
  //     ...queryParameters,
  //     "appId": ApiUrl.appId,
  //     "appCategory": ApiUrl.appCategory
  //   };
  //   headers.addAll(dio.options.headers);
  //   final response = await dio.get(
  //     url,
  //     queryParameters: updateQueryParameters,
  //     options: Options(
  //       headers: headers,
  //     ),
  //   );
  //   // debugPrint('response after login: ${response.statusMessage}');
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     final resJson = response.data;
  //     debugPrint('res json: $resJson');
  //     if (resJson is String) {
  //       throw 'Unauthorized request!';
  //     } else {
  //       if (resJson['statusCode'] == null) {
  //         if (resJson.containsKey('data')) {
  //           resJson['statusCode'] = 200;
  //         }
  //       }
  //       if (resJson['statusCode'] == 200) {
  //         if (resJson['data'] is List) {
  //           debugPrint('is list: ${resJson['data'].length}');
  //           final returnData = {
  //             'dataList': resJson['data'],
  //           };
  //           if (resJson.containsKey('meta')) {
  //             if (resJson['meta'].containsKey('last_page')) {
  //               returnData.putIfAbsent(
  //                   'lastPage', () => resJson['meta']['last_page']);
  //             }
  //             if (resJson['meta'].containsKey('total')) {
  //               returnData.putIfAbsent('total', () => resJson['meta']['total']);
  //             }
  //           }
  //           return returnData;
  //         }
  //         return resJson['data'] ?? {};
  //       } else {
  //         throw resJson['message'];
  //       }
  //     }
  //   } else {
  //     final resJson = response.data;
  //     debugPrint('res data out 200: $resJson');
  //     if (resJson != null) {
  //       debugPrint('res json out 200: $resJson');
  //       if (resJson is String) {
  //         throw response.statusMessage ?? 'Something went wrong!';
  //       } else {
  //         if (resJson.containsKey('message')) {
  //           debugPrint('res js me: : ${resJson['message']}');
  //           throw resJson['message'];
  //         }
  //       }
  //     }
  //     throw response.statusMessage ?? 'Something went wrong!';
  //   }
  // }

  // Future<Map<String, dynamic>> updateData({
  //   required String url,
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  // }) async {
  //   final dio = ds.dio;
  //   Map<String, dynamic> headers = {};
  //   headers.addAll(dio.options.headers);
  //   final updatedData = {...data, "appId": ApiUrl.appId};
  //   // ///for file upload change Content-Type
  //   // if (isFileUpload) {
  //   //   headers.update('Content-Type', (value) => 'multipart/form-data');
  //   // }
  //   debugPrint('headers: ${headers['Content-Type']}');
  //   debugPrint('data : $data');
  //   final response = await dio.patch(
  //     url,
  //     data: updatedData,
  //     queryParameters: queryParameters,
  //     options: Options(
  //       headers: headers,
  //     ),
  //   );
  //   debugPrint('response post: ${response.statusCode}');
  //   debugPrint('response post data: ${response.data}');
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     final resJson = response.data;
  //     debugPrint('rr $resJson');
  //     if (resJson is String) {
  //       throw 'Unauthorized request!';
  //     } else {
  //       debugPrint('response json: ${resJson['statusCode']}');
  //       if (resJson['statusCode'] == 200 || resJson['statusCode'] == 201) {
  //         if (resJson.containsKey('data')) {
  //           if (resJson['data'] is List) {
  //             debugPrint('is list: ${resJson['data'].length}');
  //             final returnData = {
  //               'dataList': resJson['data'],
  //             };
  //             if (resJson.containsKey('meta')) {
  //               if (resJson['meta'].containsKey('last_page')) {
  //                 returnData.putIfAbsent(
  //                     'lastPage', () => resJson['meta']['last_page']);
  //               }
  //               if (resJson['meta'].containsKey('total')) {
  //                 returnData.putIfAbsent(
  //                     'total', () => resJson['meta']['total']);
  //               }
  //             }
  //             return returnData;
  //           }
  //           return resJson['data'] ?? {};
  //         } else {
  //           return resJson;
  //         }
  //       } else {
  //         throw resJson['message'];
  //       }
  //     }
  //   } else {
  //     final resJson = response.data;
  //     debugPrint('res data out 200: $resJson');
  //     if (resJson != null) {
  //       debugPrint('res json out 200: $resJson');
  //       if (resJson.containsKey('message')) {
  //         debugPrint('res js me: : ${resJson['message']}');
  //         if (resJson.containsKey('data')) {
  //           if (resJson['data'].length >= 1) {
  //             debugPrint(
  //                 'keys erro :${resJson['data']} type: ${resJson['data'].runtimeType}');
  //             throw resJson['data'][resJson['data'].keys.first][0];
  //           }
  //         }
  //         throw resJson['message'];
  //       }
  //     }
  //     throw response.statusMessage ?? 'Something went wrong!';
  //   }
  // }

  Future<String> deleteData({
    required String url,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final dio = ds.dio;
    Map<String, dynamic> headers = {};
    headers.addAll(dio.options.headers);
    final response = await dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final resJson = response.data;
      if (resJson is String) {
        throw 'Unauthorized request!';
      } else {
        if (resJson['statusCode'] == 200) {
          return resJson['message'];
        } else {
          throw resJson['message'];
        }
      }
    } else {
      final resJson = response.data;
      debugPrint('res data out 200: $resJson');
      if (resJson != null) {
        debugPrint('res json out 200: $resJson');
        if (resJson.containsKey('message')) {
          debugPrint('res js me: : ${resJson['message']}');
          throw resJson['message'];
        }
      }
      throw response.statusMessage ?? 'Something went wrong!';
    }
  }
}

DioClient get dioClient => DioClient.instance;
