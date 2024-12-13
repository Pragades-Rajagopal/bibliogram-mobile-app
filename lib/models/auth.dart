import 'package:bibliogram/models/base_response.dart';

class Login {
  String? username;
  String? privateKey;
}

class LoginResponse extends BaseResponse {
  String? token;

  LoginResponse({
    super.statusCode,
    super.message,
    this.token,
  });

  LoginResponse.fromJSON(super.json)
      : token = json["token"],
        super.fromJSON();
}

class Register {
  String? username;
  String? fullname;
}

class RegistrationResponse extends BaseResponse {
  String? privateKey;

  RegistrationResponse({
    super.statusCode,
    super.message,
    this.privateKey,
  });

  RegistrationResponse.fromJSON(super.json)
      : privateKey = json["privateKey"],
        super.fromJSON();
}

class LogoutResponse extends BaseResponse {
  String? error;

  LogoutResponse({
    super.statusCode,
    super.message,
    this.error,
  });

  LogoutResponse.fromJSON(super.json)
      : error = json["error"],
        super.fromJSON();
}

class DeactivateUserResponse extends BaseResponse {
  DeactivateUserResponse({
    super.statusCode,
    super.message,
  });

  DeactivateUserResponse.fromJSON(super.json) : super.fromJSON();
}
