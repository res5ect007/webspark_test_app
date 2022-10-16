class OutputDataList {
  OutputDataList({
    required this.outputData,
  });

  late final OutputData outputData;

  List<dynamic> toJson() {
    final data = [];
    data.add(outputData);
    return data;
  }

}

class OutputData {
  OutputData({
    required this.id,
    required this.result,
  });

  late final String id;
  late final Result result;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['result'] = result.toJson();
    return data;
  }

}

class Result {
  Result({
    required this.steps,
    required this.path,
  });

  late final List<Steps> steps;
  late final String path;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['steps'] = steps.map((e) => e.toJson()).toList();
    data['path'] = path;
    return data;
  }
}

class Steps {
  Steps({
    required this.x,
    required this.y,
  });

  late final String x;
  late final String y;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    return data;
  }
}
