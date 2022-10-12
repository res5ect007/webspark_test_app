import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/input_data.dart';
import 'error_controller.dart';
import '../services/http_client.dart';

class InputDataController extends GetxController with ErrorController {
  String _url = '';
  late HttpClient _httpClient;
  var inputData = InputData.obs;
  var isLoading = false.obs;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isLoading(true);

    _httpClient = HttpClient();
    await _httpClient
        .get(_url)
        .then((value) {
      inputData = InputData.fromJson(jsonDecode(value));
      isLoading(false);
    }).catchError(handleError);

  }
}