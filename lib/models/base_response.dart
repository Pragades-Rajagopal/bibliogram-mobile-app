/// Base class for common response properties
class BaseResponse {
  int? statusCode;
  String? message;

  BaseResponse({
    this.statusCode,
    this.message,
  });

  BaseResponse.fromJSON(Map<String, dynamic> json) {
    statusCode = json["statusCode"];
    message = json["message"];
  }
}
