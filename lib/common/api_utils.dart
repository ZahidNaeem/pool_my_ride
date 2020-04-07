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
    final Dio dio = new Dio();
    // dio.options.baseUrl = Constant.API_BASE_URL;
    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (jwt != null) {
      headers['Authorization'] = 'Bearer ' + jwt;
    }

    options.headers = headers;
    try {
      final Response response =
          await dio.request(path, data: data, options: options);
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.accepted) {
        return APIResponse(data: response.data);
      } else {
        return APIResponse(
            error: true,
            errorMessage:
                'An error occured with message:\t' + response.statusMessage);
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
