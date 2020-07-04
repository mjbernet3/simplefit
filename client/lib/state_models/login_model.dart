import 'package:client/services/auth_service.dart';
import 'package:client/state_models/state_model.dart';
import 'package:client/utils/page_state.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/structures/response.dart';

class LoginModel extends StateModel {
  AuthService _authService;

  LoginModel({AuthService authService}) : _authService = authService;

  Future<Response> signIn(AuthInfo authInfo) async {
    setState(PageState.LOADING);
    Response response = await _authService.signIn(authInfo);

    /*
      Since AuthBuilder rebuilds the application based on the onAuthStateChanged
      stream, automatic redirection to the home page will occur on successful
      sign in. This check ensures that the model does not invoke notifyListeners
      on an already disposed state.
     */
    if (response.status == Status.FAILURE) {
      setState(PageState.IDLE);
    }

    return response;
  }
}
