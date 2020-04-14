import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:poolmyride/util/constant.dart';
import 'package:poolmyride/model/api_response.dart';

class APIUtils {
  static Future<APIResponse> request(
      {@required final String path, Options options, dynamic data}) async {
    final String jwt = await Constant.storage.read(key: 'jwt');
    APIResponse apiResponse;
    final Dio dio = new Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print('Request data: ' + options.data);
      print('Request method: ' + options.method);
      print('Request path: ' + options.path);
      print('Request headers: ' + options.headers.toString());
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // Do something with response data
      print('Response: ' + response.toString());
      apiResponse = APIResponse.fromJson(json.decode(response.toString()));
      return apiResponse; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      final Response<dynamic> response = e.response;
      apiResponse = APIResponse.fromJson(response.data);
      print('Error status code: ' + response.statusCode.toString());
      print('Error entity: ' + apiResponse.entity.toString());
      print('Error message: ' + apiResponse.message);
      return apiResponse; //continue
    }));
    // dio.options.baseUrl = Constant.API_BASE_URL;
    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (jwt != null) {
      headers['Authorization'] = 'Bearer ' + jwt;
    }

    options.headers = headers;
    options.receiveDataWhenStatusError = true;
    try {
      final Response response =
          await dio.request(path, data: data, options: options);
//      if (response.statusCode == HttpStatus.ok ||
//          response.statusCode == HttpStatus.accepted) {
      return apiResponse;
//      if (apiResponse.success) {
//      } else {
//        return APIResponse(success: false, message: apiResponse.message);
//      }
    } catch (e) {
      return APIResponse(success: false, message: apiResponse.message);
    }
  }
}
