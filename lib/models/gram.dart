import 'package:bibliogram/models/base_response.dart';

class GetGramsResponse extends BaseResponse {
  List<dynamic>? data;
  int? count;

  GetGramsResponse({
    super.statusCode,
    super.message,
    this.data,
    this.count,
  });

  GetGramsResponse.fromJSON(super.json)
      : data = json["data"],
        count = json["count"],
        super.fromJSON();
}
