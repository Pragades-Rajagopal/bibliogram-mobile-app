import 'package:bibliogram/models/base_response.dart';

class GetCommentsResponse extends BaseResponse {
  List<dynamic>? data;
  int? count;

  GetCommentsResponse({
    super.statusCode,
    super.message,
    this.data,
    this.count,
  });

  GetCommentsResponse.fromJSON(super.json)
      : data = json["data"],
        count = json["count"],
        super.fromJSON();
}
