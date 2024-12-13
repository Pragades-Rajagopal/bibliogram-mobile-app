import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/models/auth.dart';
import 'package:bibliogram/networks/http.dart';

class AuthApi {
  HttpRequest httpRequest = HttpRequest();

  Future<LoginResponse> login(Map<String, String> request) async {
    try {
      final httpRes = await httpRequest.post('${endpoints["login"]}', request);
      LoginResponse response = LoginResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<RegistrationResponse> register(Map<String, String> request) async {
    try {
      final httpRes =
          await httpRequest.post('${endpoints["register"]}', request);
      RegistrationResponse response = RegistrationResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
