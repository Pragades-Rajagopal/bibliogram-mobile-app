import 'package:bibliogram/utils/token_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserToken {
  static final UserToken instance = UserToken.internal();
  static SharedPreferences? preferences;

  UserToken.internal();

  factory UserToken() => instance;

  Future<void> _init() async =>
      preferences ??= await SharedPreferences.getInstance();

  Future<void> storeTokenData(String token) async {
    await _init();
    final payloadData = parseJwt(token);
    await preferences!.setString('user_id', payloadData["id"]);
    await preferences!.setString('fullname', payloadData["fullname"]);
    await preferences!.setString('username', payloadData["username"]);
    await preferences!.setString('token', token);
  }

  Future<Map<String, dynamic>> getTokenData() async {
    await _init();
    return {
      "id": preferences!.getString('user_id'),
      "name": preferences!.getString('fullname'),
      "username": preferences!.getString('username'),
      "token": preferences!.getString('token'),
    };
  }

  Future<void> purgeTokenData() async {
    await _init();
    await preferences!.remove('user_id');
    await preferences!.remove('fullname');
    await preferences!.remove('username');
    await preferences!.remove('token');
  }
}
