import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/models/app_stats.dart';
import 'package:bibliogram/networks/http.dart';

class AppStatsApi {
  HttpRequest httpRequest = HttpRequest();

  Future<AppStatsResponse> get(String token, String userId) async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["appStats"]}',
        token: token,
        userId: userId,
      );
      AppStatsResponse response = AppStatsResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
