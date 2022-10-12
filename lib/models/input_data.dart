
import 'dart:convert';

// inputDataFromJson(String str) {
//   InputData = InputData.fromJson(str as String);
// }

List<InputData> inputDataFromJson(String str) => List<InputData>.from(json.decode(str).map((x) => InputData.fromJson(x)));

class InputData {
  static var obs;

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

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['message'] = message;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
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
  late final Start start;
  late final End end;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = List.castFrom<dynamic, String>(json['field']);
    start = Start.fromJson(json['start']);
    end = End.fromJson(json['end']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['field'] = field;
    _data['start'] = start.toJson();
    _data['end'] = end.toJson();
    return _data;
  }
}

class Start {
  Start({
    required this.x,
    required this.y,
  });

  late final int x;
  late final int y;

  Start.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['x'] = x;
    _data['y'] = y;
    return _data;
  }
}

class End {
  End({
    required this.x,
    required this.y,
  });

  late final int x;
  late final int y;

  End.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['x'] = x;
    _data['y'] = y;
    return _data;
  }
}
