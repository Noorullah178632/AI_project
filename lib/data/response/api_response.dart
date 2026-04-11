import 'package:ai_project/data/response/app_status.dart';

class ApiResponse<T> {
  Status? status;
  T? message;
  String? error;

  ApiResponse.completed(this.message) : status = Status.COMPLETED;
  ApiResponse.error(this.error) : status = Status.ERROR;
  ApiResponse.loading() : status = Status.LOADING;

  @override
  String toString() {
    return "Status: $status \nMessage: $message \nError :$error";
  }
}
