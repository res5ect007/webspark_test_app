import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/input_data.dart';
import 'error_controller.dart';
import '../services/http_client.dart';

class InputDataController extends GetxController with ErrorController {
  String _url = '';
  late HttpClient _httpClient;
  late InputData inputData;
  var isLoading = false.obs;
  late List dataList = [];
  late List startDataPoints = [];
  late List endDataPoints = [];
  late List exclusionDataList = [];
  late int selectedDataList = 0.obs as int;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isLoading(true);

    _httpClient = HttpClient();
    await _httpClient
        .get(_url)
        .then((value) {

      inputData = InputData.fromJson(jsonDecode(value));
      structureData(inputData);
      findBestResult(inputData);
      // Future.delayed(const Duration(milliseconds: 5000), () async {});
      isLoading(false);
    }).catchError(handleError);
  }

  Future<void> structureData(InputData inputData) async {
    var dataSize = inputData.data.length;

    for (int i = 0; i < dataSize; i++) {

      int tableSize = inputData.data[i].field.length;
      List tableList = [];
      List startPoint = [];
      List endPoint = [];
      List exclusionList = [];

      startPoint.add(inputData.data[i].start.x + inputData.data[i].start.y / 10);
      endPoint.add(inputData.data[i].end.x + inputData.data[i].end.y / 10);

      for (int n = 0; n < tableSize; n++) {

        int stringLenth = inputData.data[i].field[n].length;
        for (int m = 0; m < stringLenth; m++) {
          var point = m + n/10;
          tableList.add(point);

          if (inputData.data[i].field[n][m] == 'X') {
            exclusionList.add(point);
          }
        }
      }
      dataList.add(tableList);
      startDataPoints.add(startPoint);
      endDataPoints.add(endPoint);
      exclusionDataList.add(exclusionList);
    }
  }

  Future<void> findBestResult(InputData inputData) async {
  }
}