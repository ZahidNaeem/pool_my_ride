import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:poolmyride/common/constant.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/model/login_request.dart';

class APIUtils {
  static Future<APIResponse> request(
      {@required final String path, Options options, dynamic data}) async {
    final String jwt = await Constant.storage.read(key: 'jwt');
    DioError dioError = null;
    final Dio dio = new Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print('Request: ' + options.toString());
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // Do something with response data
      print('Response: ' + response.toString());
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      dioError = e;
      print('Error in request: ' + e.toString());
      return e; //continue
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
      if (dioError == null) {
        return APIResponse(data: response.data);
      } else {
        return APIResponse(
            error: true,
            errorMessage:
                'An error occured with message:\t' + dioError.toString());
      }
    } catch (e) {
      print(e.toString());
      return APIResponse(error: true, errorMessage: e.toString());
    }
  }

  static Future<APIResponse> login(final LoginRequest logingRequest) async {
    var encodedRequest = json.encode(logingRequest.toJson());
    print('encodedRequest: $encodedRequest');
    final Options options = Options(method: 'POST');
    var response = await APIUtils.request(
        path: Constant.API_LOGIN_URL, options: options, data: encodedRequest);
    if (response.error == true) {
      print('Error in login request: ${response.errorMessage}');
      throw new Exception(response.errorMessage);
    } else {
      var data = response.data['entity']['accessToken'];
      await Constant.storage.write(key: 'jwt', value: data);
      return response;
    }
  }

  static Future<APIResponse> signup() async {
    final Options options = Options(method: 'POST');
    var response = await APIUtils.request(
        path: Constant.API_SIGNUP_URL,
        options: options,
        data: {'usernameOrEmail': 'zahid', 'password': '111111'});
    var data = response.data['entity']['accessToken'];
    await Constant.storage.write(key: 'jwt', value: data);
    return response;
  }
}
