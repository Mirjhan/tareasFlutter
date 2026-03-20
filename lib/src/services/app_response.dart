class AppResponse {
  int statusCode;
  Map<String, String> headers;
  String body;

  AppResponse({
    required this.statusCode,
    required this.headers,
    required this.body,
  });

  bool get isSucces => (statusCode >= 200 && statusCode <= 299);
}
