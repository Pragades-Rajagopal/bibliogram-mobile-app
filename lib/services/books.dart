import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/models/books.dart';
import 'package:bibliogram/networks/http.dart';

class BooksApi {
  String token;
  String userId;

  BooksApi(this.token, this.userId);
  HttpRequest httpRequest = HttpRequest();

  Future<BooksResponse> getTopBooks() async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["topBooks"]}',
        token: token,
        userId: userId,
      );
      BooksResponse response = BooksResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
