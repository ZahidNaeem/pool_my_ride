import 'package:poolmyride/controller/auth_controller.dart';
import 'package:poolmyride/model/api_response.dart';
import 'package:poolmyride/model/login_request.dart';

class AuthRepository {
  Future<APIResponse> login(final LoginRequest logingRequest) async {
    return await AuthController.login(logingRequest);
  }
}
