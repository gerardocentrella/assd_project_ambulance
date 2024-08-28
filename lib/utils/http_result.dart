class HttpResult<T> {
  final T? data;
  final int? httpStatusCode;
  final String? error;

  HttpResult({this.data, this.httpStatusCode, this.error});
}
