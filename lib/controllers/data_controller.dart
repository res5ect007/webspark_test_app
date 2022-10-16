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
  late List<List<Point>> dataBestWay;
  var isLoading = false.obs;
  var loadingPercent = ''.obs;
  var isSending = false.obs;
  late int selectedDataList = 0.obs as int;

  Future<void> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isLoading(true);
    loadingPercent.value = '10';

    _httpClient = HttpClient();
    await _httpClient.get(_url).then((value) {
      inputData = InputData.fromJson(jsonDecode(value));
      loadingPercent.value = '30';
      structureData(inputData);
      loadingPercent.value = '100';
      isLoading(false);
    }).catchError(handleError);
  }

  Future<void> sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _url = (prefs.getString('URL') ?? '');
    isSending(true);

    OutputDataList outputData = OutputDataList(outputData: OutputData(id: '345334534', result: Result(steps: [Steps(y: '1', x: '2'), Steps(y: '4', x: '5')], path: '123')));
    var gjhk = outputData.toJson();

    String json = jsonEncode(gjhk);

    _httpClient = HttpClient();
    await _httpClient.post(_url, json).then((value) {
      isSending(false);
    }).catchError(handleError);
  }

  Future<void> structureData(InputData inputData) async {

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

      int moveX = rvtableXY[endPoint]!.x > rvtableXY[startPoint]!.x ? 1
                : rvtableXY[endPoint]!.x == rvtableXY[startPoint]!.x ? 0 : -1;

      int moveY = rvtableXY[endPoint]!.y > rvtableXY[startPoint]!.y ? 1
                : rvtableXY[endPoint]!.y == rvtableXY[startPoint]!.y ? 0 : -1;

      var percent = 60/(data.length+i);
      loadingPercent.value = '${percent.ceil()}';
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

        findBestWay(tablePoint.x + moveX, tablePoint.y, currentBestWay, tempBestWayList); //Try X
        findBestWay(tablePoint.x, tablePoint.y + moveY, currentBestWay, tempBestWayList); //Try Y
        findBestWay(tablePoint.x + moveX, tablePoint.y + moveY, currentBestWay, tempBestWayList); //Try XY
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


  }

}
