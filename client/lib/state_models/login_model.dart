import 'package:client/services/auth_service.dart';
import 'package:client/state_models/state_model.dart';
import 'package:client/utils/response.dart';

class LoginModel extends StateModel {
  AuthService _authService;

  LoginModel({AuthService authService}) : _authService = authService;

  Future<Response> signIn(String email, String password) async {
    setLoading(true);
    Response response = await _authService.signIn(email, password);
    setLoading(false);
    return response;
  }
}
