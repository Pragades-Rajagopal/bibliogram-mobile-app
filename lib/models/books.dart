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

/// Model for fetching book by id
class BookByIdResponse extends BaseResponse {
  List<dynamic>? data;

  BookByIdResponse({
    super.statusCode,
    super.message,
    this.data,
  });

  BookByIdResponse.fromJSON(super.json)
      : data = json["data"],
        super.fromJSON();
}
