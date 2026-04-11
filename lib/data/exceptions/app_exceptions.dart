class AppExceptions implements Exception {
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  final _message;
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

// 1. Network / Internet Issue
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
    : super(message, "Error During Communication: ");
}

// 2. URL Not Found (404)
class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

// 3. Unauthorized (401 / 403)
class UnauthorisedException extends AppExceptions {
  UnauthorisedException([String? message])
    : super(message, "Unauthorised Request: ");
}

// 4. Invalid Input (422)
class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

// 5. Request Timeout
class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String? message])
    : super(message, "Request Timeout: ");
}
