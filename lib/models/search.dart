import 'package:bibliogram/models/base_response.dart';

class SearchResponse extends BaseResponse {
  List<dynamic>? data;
  int? count;

  SearchResponse({
    super.statusCode,
    super.message,
    this.data,
    this.count,
  });

  SearchResponse.fromJSON(super.json)
      : data = json["data"],
        count = json["count"],
        super.fromJSON();
}
