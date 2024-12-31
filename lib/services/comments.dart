import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/models/comment.dart';
import 'package:bibliogram/networks/http.dart';

enum GetCommentCondition { gramId, userId }

class CommentsApi {
  String token;
  String userId;

  CommentsApi(this.token, this.userId);
  HttpRequest httpRequest = HttpRequest();

  Future<GetCommentsResponse> getComments(String id,
      {int limit = 10, int offset = 0}) async {
    try {
      final httpRes = await httpRequest.get(
        '${endpoints["comment"]}?gramId=$id&limit=$limit&offset=$offset',
        token: token,
        userId: userId,
      );
      GetCommentsResponse response = GetCommentsResponse.fromJSON(httpRes);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
