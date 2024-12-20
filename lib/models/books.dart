import 'package:bibliogram/models/base_response.dart';

/// Model for Top books and fetch books by query
class BooksResponse extends BaseResponse {
  List<dynamic>? data;
  int? count;

  BooksResponse({
    super.statusCode,
    super.message,
    this.data,
    this.count,
  });

  BooksResponse.fromJSON(super.json)
      : data = json["data"],
        count = json["count"],
        super.fromJSON();
}
