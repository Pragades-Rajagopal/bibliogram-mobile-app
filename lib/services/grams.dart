import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/models/gram.dart';
import 'package:bibliogram/networks/http.dart';

class GramsApi {
  String token;
  String userId;

  GramsApi(this.token, this.userId);
  HttpRequest httpRequest = HttpRequest();

  Future<GetGramsResponse> getGlobalGrams(int limit, int offset) async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["grams"]}?limit=$limit&offset=$offset',
        token: token,
        userId: userId,
      );
      GetGramsResponse response = GetGramsResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetGramResponse> getGramById(String id) async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["gram"]}/$id',
        token: token,
        userId: userId,
      );
      GetGramResponse response = GetGramResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<GetGramsResponse> getGramsByQuery(String id, String condition,
      {int limit = 10, int offset = 0}) async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["grams"]}?limit=$limit&offset=$offset&$condition=$id',
        token: token,
        userId: userId,
      );
      GetGramsResponse response = GetGramsResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
