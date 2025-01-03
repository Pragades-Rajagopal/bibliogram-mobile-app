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

class GetGramResponse extends BaseResponse {
  List<dynamic>? data;
  int? count;

  GetGramResponse({super.statusCode, super.message, this.data, this.count});

  GetGramResponse.fromJSON(super.json)
      : data = json["data"],
        count = json["count"],
        super.fromJSON();
}

class GetGramBookmarksResponse extends BaseResponse {
  List<dynamic>? data;
  int? count;

  GetGramBookmarksResponse({
    super.statusCode,
    super.message,
    this.data,
    this.count,
  });

  GetGramBookmarksResponse.fromJSON(super.json)
      : data = json["data"],
        count = json["count"],
        super.fromJSON();
}

class PostGramResponse extends BaseResponse {
  PostGramResponse({
    super.statusCode,
    super.message,
  });

  PostGramResponse.fromJSON(super.json) : super.fromJSON();
}
