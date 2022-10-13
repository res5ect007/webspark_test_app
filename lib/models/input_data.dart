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
  late final Start start;
  late final End end;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = List.castFrom<dynamic, String>(json['field']);
    start = Start.fromJson(json['start']);
    end = End.fromJson(json['end']);
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
}
