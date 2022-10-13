import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/input_data.dart';
import '../models/output_data.dart';
import 'error_controller.dart';
import '../services/http_client.dart';

class DataController extends GetxController with ErrorController {
  String _url = '';
  late HttpClient _httpClient;
  late InputData inputData;
  late OutputData outputData;
  var isLoading = false.obs;
  var loadingPercent = ''.obs;
  var isSending = false.obs;
  late List dataList = [];
  late List startDataPoints = [];
  late List endDataPoints = [];
  late List exclusionDataList = [];
  late List bestWayList = [];
  late int selectedDataList = 0.obs as int;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isLoading(true);
    loadingPercent.value = '10';

    _httpClient = HttpClient();
    await _httpClient.get(_url).then((value) {
      inputData = InputData.fromJson(jsonDecode(value));
      structureData(inputData);
      loadingPercent.value = '100';
      isLoading(false);
    }).catchError(handleError);
  }

  Future<void> sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isSending(true);

   // outputData = OutputData.toJson(jsonDecode(value)) as OutputData;

    // _httpClient = HttpClient();
    // await _httpClient.post(_url, outputData).then((value) {
    //
    //   isSending(false);
    // }).catchError(handleError);
  }

  Future<void> structureData(InputData inputData) async {
    int dataSize = inputData.data.length;
    List outputData = [];

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
    loadingPercent.value = '50';

    //Find best way
    dataSize = dataList.length;
    for (int i = 0; i < dataSize; i++) {

      List currentList = dataList[i];
      //List currentExclusionList = exclusionDataList[i];
      double currentStartPoint = startDataPoints[i][0];
      double currentEndPoint = endDataPoints[i][0];

      List availablePointList = [];
      availablePointList.addAll(currentList);

      //delete all not available points
      for (int n = 0; n < exclusionDataList[i].length; n++) {
        availablePointList.remove(exclusionDataList[i][n]);
        availablePointList.remove(currentStartPoint);
      }

      // List currentWayAvailablePointList = [];
      // currentWayAvailablePointList.addAll(availablePointList);

      List<double> wayList = [0.9,  1.1, -1, -0.9,  -1.1, 0.1, 1, -0.1,];

      String bestWay = '';
      Map step = <String, int>{};
      List steps = [];
      List result = [];
      bestWay = getWayFormated(currentStartPoint, bestWay);
      //List bestWayList = [];

      findBestResult(wayList, currentStartPoint, currentEndPoint) {

        for (int m = 0; m < wayList.length - 1; m++) {
          double stepPoint = currentStartPoint + wayList[m];
          stepPoint = double.parse((stepPoint).toStringAsFixed(1));

          if (availablePointList.contains(stepPoint)) {
            availablePointList.remove(stepPoint);
            bestWay = bestWay + getWayFormated(stepPoint, bestWay);

            dynamic stepPointX = int.parse(stepPoint.toString().substring(0, 1));
            dynamic stepPointY = int.parse(stepPoint.toString().substring(2, 3));
            step = {'x': stepPointX, 'y': stepPointY};
            steps.add(step);

            if (currentEndPoint == stepPoint) {
              //bestWayList.add(bestWay);
              result.add({'steps': steps});
              result.add({'path': bestWay});
              availablePointList.clear();
            } else {
              findBestResult(wayList, stepPoint, currentEndPoint);
            }
          }
        }
      }

      findBestResult(wayList, currentStartPoint, currentEndPoint);
      bestWayList.add(bestWay);
      loadingPercent.value = '75';

      outputData.add({
          'id': inputData.data[i].id, 'result': result});
    }

  }

}

getWayFormated(point,bestWay) => bestWay.isNotEmpty ? '->($point)' : '($point)';