
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../models/input_data.dart';
import '../widgets/point_widget.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({Key? key}) : super(key: key);
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    Data data = dataController.inputData.data[dataController.selectedDataList];
    int dataListLength = data.dataList.length;
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
            return
              pointWidget(
                  data.dataList[index],
                  data.exclusionList,
                  data.start,
                  data.end,
                  dataController.dataBestWay[dataController.selectedDataList]
              );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
      );
  }
}
