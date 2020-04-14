import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:poolmyride/util/api_utils.dart';
import 'package:poolmyride/util/constant.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/model/login_request.dart';

class AuthController {
  static Future<APIResponse> login(final LoginRequest logingRequest) async {
    final String _encodedRequest = json.encode(logingRequest.toJson());
    final Options _options = Options(method: 'POST');
    final APIResponse response = await APIUtils.request(
        path: Constant.API_LOGIN_URL, options: _options, data: _encodedRequest);
    if (response.success) {
      var data = response.entity['accessToken'];
      await Constant.storage.write(key: 'jwt', value: data);
    }
    return response;
  }

  static Future<APIResponse> signup() async {
    final Options options = Options(method: 'POST');
    final APIResponse response = await APIUtils.request(
        path: Constant.API_SIGNUP_URL,
        options: options,
        data: {'usernameOrEmail': 'zahid', 'password': '111111'});
    var data = response.entity['entity']['accessToken'];
    await Constant.storage.write(key: 'jwt', value: data);
    return response;
  }
}
