import 'package:bibliogram/models/base_response.dart';

class AppStatsResponse extends BaseResponse {
  List? data;

  AppStatsResponse({
    super.statusCode,
    super.message,
    this.data,
  });

  AppStatsResponse.fromJSON(super.json)
      : data = json["data"],
        super.fromJSON();
}
