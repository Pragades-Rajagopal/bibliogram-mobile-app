import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bibliogram/configurations/dotenv.dart';

Map<String, String> apiHeader = {
  'Content-type': 'application/json',
  'Accept': 'application/json'
};

class HttpRequest {
  Map<String, String>? _env;

  Future<void> _loadEnv() async =>
      _env ??= await accessEnv(assetFileName: '.env');

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> request, {
    String token = '',
    String userId = '',
  }) async {
    await _loadEnv();
    if (token.isNotEmpty) apiHeader["Authorization"] = 'Bearer $token';
    if (userId.isNotEmpty) apiHeader["userId"] = userId;
    var response = await http.post(
      Uri.parse('${_env?["URL"]}$endpoint'),
      headers: apiHeader,
      body: json.encode(request),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> get(
    String endpoint, {
    String token = '',
    String userId = '',
  }) async {
    await _loadEnv();
    if (token.isNotEmpty) apiHeader["Authorization"] = 'Bearer $token';
    if (userId.isNotEmpty) apiHeader["userId"] = userId;
    var response = await http.get(
      Uri.parse('${_env?["URL"]}$endpoint'),
      headers: apiHeader,
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> request, {
    String token = '',
    String userId = '',
  }) async {
    await _loadEnv();
    if (token.isNotEmpty) apiHeader["Authorization"] = 'Bearer $token';
    if (userId.isNotEmpty) apiHeader["userId"] = userId;
    var response = await http.put(
      Uri.parse('${_env?["URL"]}$endpoint'),
      headers: apiHeader,
      body: json.encode(request),
    );
    return jsonDecode(response.body);
  }

  Future<dynamic> delete(
    String endpoint, {
    String token = '',
    String userId = '',
  }) async {
    await _loadEnv();
    if (token.isNotEmpty) apiHeader["Authorization"] = 'Bearer $token';
    if (userId.isNotEmpty) apiHeader["userId"] = userId;
    var response = await http.delete(
      Uri.parse('${_env?["URL"]}$endpoint'),
      headers: apiHeader,
    );
    return jsonDecode(response.body);
  }
}
