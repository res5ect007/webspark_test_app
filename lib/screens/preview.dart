import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/input_data_controller.dart';
import '../widgets/point_widget.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({Key? key}) : super(key: key);
  final InputDataController dataController = Get.put(InputDataController());

  @override
  Widget build(BuildContext context) {
    int dataListLength =
        dataController.dataList[dataController.selectedDataList].length;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Preview screen'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          )),
      body: GridView.builder(
        itemCount: dataListLength,
        itemBuilder: (BuildContext context, int index) {
          return pointWidget(
            dataController.dataList[dataController.selectedDataList][index],
            dataController.exclusionDataList[dataController.selectedDataList],
            dataController.startDataPoints[dataController.selectedDataList],
            dataController.endDataPoints[dataController.selectedDataList],
          );
        },
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: Get.width / sqrt(dataListLength),
        ),
      ),
    );
  }
}
