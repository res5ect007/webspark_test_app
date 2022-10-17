import 'dart:convert';
import 'dart:math';
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
  late List<OutputData> outputData = [];
  late List<List<Point>> dataBestWay;
  late  List<List<Point>> previewList = [];
  var isLoading = false.obs;
  var loadingPercent = 0.0.obs;
  var isSending = false.obs;
  late int selectedDataList = 0.obs as int;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isLoading(true);
    loadingPercent.value = 0.0;

    _httpClient = HttpClient();
    await _httpClient.get(_url).then((value) async {
      inputData = InputData.fromJson(jsonDecode(value));
      structureInputData();
    }).catchError(handleError);
  }

  Future<void> sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isSending(true);

    structureOutputData();
    String json = jsonEncode(outputData);

    _httpClient = HttpClient();
    await _httpClient.post(_url, json).then((value) {
      Get.toNamed('/result');
    }).catchError(handleError);

    isSending(false);
  }

  Future<void> structureInputData() async {

    loadingPercent.value = 0.3;
    List<Data> data = inputData.data;
    dataBestWay = [];


    for (int i = 0; i < data.length; i++) {
      Point startPoint = data[i].start;
      Point endPoint   = data[i].end;
      List<Point> exclusionList = data[i].exclusionList;
      Map<TablePoint, Point> tableXY = data[i].tableXY;
      Map<Point, TablePoint> rvtableXY = data[i].rvtableXY;
      List<Point> bestWay = [startPoint];
      List<Point> endPointList = [];
      List<List<Point>> bestWayList = [bestWay];

      sortToPrewiev() {
        List<Point> _previewList = [];
        int dataListLength = data[i].dataList.length;
        int rowCount = sqrt(dataListLength).toInt();
        int x = 0;
        int y = 0;
        int counter = 1;
        for (int k = 0; k < dataListLength; k++) {
          _previewList.add(Point(x: x, y: y));

          if ((k + 1) / counter == rowCount){
            x = 0;
          } else {
            x++;
          }

          if ((k + 1) == rowCount * counter){
            y++;
          }

          if ( (k + 1) % rowCount == 0){
            counter++;
          }
        }
        previewList.add(_previewList);
      }
      sortToPrewiev();

      int moveX = rvtableXY[endPoint]!.x > rvtableXY[startPoint]!.x ? 1
                : rvtableXY[endPoint]!.x == rvtableXY[startPoint]!.x ? 0 : -1;

      int moveY = rvtableXY[endPoint]!.y > rvtableXY[startPoint]!.y ? 1
                : rvtableXY[endPoint]!.y == rvtableXY[startPoint]!.y ? 0 : -1;


      var percent = 60 / (data.length + i);
      loadingPercent.value = loadingPercent.value + percent/100;

      findBestWay(x, y, currentBestWay, tempBestWayList) {
        TablePoint currentTablePoint = TablePoint(x: x, y: y);
        Point? currentPoint = tableXY[currentTablePoint];
        if (currentPoint != null) {
          if (!exclusionList.contains(currentPoint)) {
          List<Point> tempBestWay = [];
          tempBestWay.addAll(currentBestWay);
          tempBestWay.add(currentPoint);
          tempBestWayList.add(tempBestWay);
          endPointList.add(currentPoint);
          }
        }
      }

      do {

        List<List<Point>> tempBestWayList = [];

      for (int n = 0; n < bestWayList.length; n++){
        Point currentPoint = bestWayList[n].last;
        List<Point> currentBestWay = bestWayList[n];
        TablePoint tablePoint = rvtableXY[currentPoint]!;

        findBestWay(tablePoint.x + moveX, tablePoint.y, currentBestWay, tempBestWayList);
        findBestWay(tablePoint.x, tablePoint.y + moveY, currentBestWay, tempBestWayList);
        findBestWay(tablePoint.x + moveX, tablePoint.y + moveY, currentBestWay, tempBestWayList);
      }

      bestWayList = tempBestWayList;
      }
      while (!endPointList.contains(endPoint));

      for (int m = 0; m < bestWayList.length; m++) {
        if (bestWayList[m].contains(endPoint)) {
          dataBestWay.add(bestWayList[m]);
        }
      }
    }
    loadingPercent.value = 1.0;
    isLoading(false);
    isSending(false);
  }

  Future<void> structureOutputData() async {

    List<Data> data = inputData.data;

    for (int i = 0; i < data.length; i++) {
      List<Steps> stepsList = [];
      for (int f = 0; f < dataBestWay[i].length; f++) {
        stepsList.add(Steps(x: dataBestWay[i][f].x.toString(), y: dataBestWay[i][f].y.toString()));
      }
      Result result = Result(steps: stepsList, path: itemsToString(dataBestWay[i]));
      outputData.add(OutputData(id: data[i].id, result: result));
    }

  }
}

itemsToString(List items) {
  String value = '';
  for (int m = 0; m < items.length; m++) {
    value =  '$value${value != '' ?  '->' : ''}(${items[m].value})';
  }
  return value;
}
