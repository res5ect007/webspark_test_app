import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_exeptions.dart';

class HttpClient {
  static const int TIME_OUT_DURATION = 10;

  //GET
  Future<dynamic> get(String baseUrl) async {
    var uri = Uri.parse(baseUrl);

    try {
      var response = await http.get(uri).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException { //No Internet
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException { //Time out
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, outputData) async {
    var uri = Uri.parse(baseUrl);

    try {
      var response = await http.post(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },body: outputData).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException { //No Internet
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException { //Time out
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: //OK
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        // return InputData.fromJson(responseJson);
      case 409: //Too Many Requests
        throw TooManyRequests(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 500: //Internal Server Error
        throw InternalServerError(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      default:
        throw FetchDataException(
            'Error occured with code: ${response.statusCode}',
            response.request?.url.toString());
    }
  }
}