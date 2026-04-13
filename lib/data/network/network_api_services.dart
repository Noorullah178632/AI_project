import 'dart:convert';
import 'dart:io';

import 'package:ai_project/data/exceptions/app_exceptions.dart';
import 'package:ai_project/data/network/base_api_services.dart';

import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  postApiServices(String url, dynamic data) async {
    // ignore: prefer_typing_uninitialized_variables
    final jsonDecode;
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 60));

      jsonDecode = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No internet connection");
    }
    return jsonDecode;
  }

  //make function for response

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 401:
      case 403:
        return UnauthorisedException(response.body.toString());
      case 400:
      case 404:
        return BadRequestException(response.body.toString());

      case 500:
      default:
        return FetchDataException("Error : ${response.body.toString()}");
    }
  }
}
