import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/models/search.dart';
import 'package:bibliogram/networks/http.dart';

class SearchApi {
  String token;
  String userId;

  SearchApi(this.token, this.userId);
  HttpRequest httpRequest = HttpRequest();

  Future<SearchResponse> getSearchResult(String value) async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["search"]}?value=$value',
        token: token,
        userId: userId,
      );
      SearchResponse response = SearchResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
