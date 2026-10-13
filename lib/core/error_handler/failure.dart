
enum FailureType {
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  validation,
  conflict,
  tooManyRequests,
  server,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  noInternet,
  badCertificate,
  cancelled,
  parsing,
  cache,
  unknown,
  transformTimeout
}

class Failure {
  final String failureMessage;
  final int? code;
  final FailureType type;
  final Object? details;

  const Failure(
    this.failureMessage, {
    this.code,
    this.type = FailureType.unknown,
    this.details,
  });

  @override
  String toString() => 'Failure(code: $code, type: $type, message: $failureMessage)';
}
