class APIError {
  APIError({this.status, this.code, this.message});

  final dynamic status;
  final String code;
  final String message;

  factory APIError.fromJson(Map<String, dynamic> json) => APIError(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
