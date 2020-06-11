import 'package:client/services/auth_service.dart';
import 'package:client/state_models/state_model.dart';
import 'package:client/utils/response.dart';

class LoginModel extends StateModel {
  AuthService _authService;

  LoginModel({AuthService authService}) : _authService = authService;

  // TODO: Handle user being either username or email
  Future<Response> signIn(String user, String password) async {
    setLoading(true);
    Response response = await _authService.signIn(user, password);
    setLoading(false);
    return response;
  }
}
