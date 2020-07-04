import 'package:client/services/auth_service.dart';
import 'package:client/state_models/state_model.dart';
import 'package:client/utils/page_state.dart';
import 'package:client/utils/structures/auth_info.dart';
import 'package:client/utils/structures/response.dart';

class RegisterModel extends StateModel {
  AuthService _authService;

  RegisterModel({AuthService authService}) : _authService = authService;

  Future<Response> register(AuthInfo authInfo) async {
    setState(PageState.LOADING);
    Response response = await _authService.register(authInfo);

    /*
      Since AuthBuilder rebuilds the application based on the onAuthStateChanged
      stream, automatic redirection to the home page will occur on successful
      registration. This check ensures that the model does not invoke
      notifyListeners on an already disposed state.
     */
    if (response.status == Status.FAILURE) {
      setState(PageState.IDLE);
    }

    return response;
  }
}
