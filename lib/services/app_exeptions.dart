class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException(this.message, this.prefix, this.url);
}

class TooManyRequests extends AppException {
  TooManyRequests(String? message, String? url) : super(message!, 'Too Many Requests', url!);
}

class InternalServerError extends AppException {
  InternalServerError(String? message, String? url) : super(message!, 'Internal Server Error', url!);
}

class FetchDataException extends AppException {
  FetchDataException(String? message, String? url) : super(message!, 'Unable to process', url!);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException(String? message, String? url) : super(message!, 'Api not responded in time', url!);
}

class BadRequestException extends AppException {
  BadRequestException(String? message, String? url) : super(message!, 'Bad Request', url!);
}