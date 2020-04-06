import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secureStorage;
import 'package:poolmyride/common/constant.dart';
import 'package:poolmyride/model/api_response.dart';

class APIUtils {
  static Future<APIResponse> request(
      {@required final String path, Options options, dynamic data}) async {
    final secureStorage.FlutterSecureStorage storage =
        new secureStorage.FlutterSecureStorage();
    String jwt = await storage.read(key: 'jwt');
    final Dio dio = new Dio();
    dio.options.baseUrl = Constant.ROOT_API;
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    headers.putIfAbsent('Authorization', 'Bearer ' + jwt);
    options.headers = headers;
    try {
      final Response response =
          await dio.request(path, data: data, options: options);
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.accepted) {
        return APIResponse(data: response.data);
      }
      return APIResponse(
          error: true,
          errorMessage:
              'An error occured with message:\t' + response.statusMessage);
    } catch (e) {
      print(e.toString());
      return APIResponse(error: true, errorMessage: e.toString());
    }
  }
}
