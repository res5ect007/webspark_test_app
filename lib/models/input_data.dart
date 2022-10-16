
import 'package:equatable/equatable.dart';

class InputData {

  InputData({
    required this.error,
    required this.message,
    required this.data,
  });

  late final bool error;
  late final String message;
  late final List<Data> data;

  InputData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

}

class Data {
  Data({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  late final String id;
  late final List<String> field;
  late final Point start;
  late final Point end;
  late Map<TablePoint, Point> tableXY = {};
  late Map<Point, TablePoint> rvtableXY = {};
  final List<Point> dataList = [];
  final List<Point> exclusionList = [];
  final List<List<Point>> bestWay = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = List.castFrom<dynamic, String>(json['field']);
    start = Point.fromJson(json['start']);
    end = Point.fromJson(json['end']);

    int counterX = 1;
    int fieldXLength = field.length;
    for (int m = 0; m < fieldXLength; m++) {

      int counterY = 3;
      int fieldYLength = field[m].length;
      for (int n = 0; n < fieldYLength; n++) {
        Point newPoint = Point(x: m, y: n);
        TablePoint newTablePoint = TablePoint(x: counterX, y: counterY);
        tableXY[newTablePoint] = newPoint;
        rvtableXY[newPoint] = newTablePoint;
        dataList.add(newPoint);
        if (field[m][n] == 'X') {
          exclusionList.add(newPoint);
        }
        counterY--;
      }
      counterX++;
    }
  }
}

class Point extends Equatable {
  Point({
    required this.x,
    required this.y,
  }) {
    value = double.parse('$x.$y');
  }

  late final int x;
  late final int y;
  late final double value;

  Point.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    value = double.parse('$x.$y');
  }

  @override
  List<Object?> get props => [x,y,value];

}

class TablePoint extends Equatable  {
  const TablePoint({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  @override
  List<Object?> get props => [x,y];
}
