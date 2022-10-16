import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../widgets/data_widget.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({Key? key}) : super(key: key);

  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Result list screen'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back),
          )),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        itemCount: dataController.dataBestWay.length,
        itemBuilder: (BuildContext context, int index) {
          List dataBestWay = dataController.dataBestWay[index];
          return GestureDetector(
              onTap: () {
                dataController.selectedDataList = index;
                Get.toNamed('/preview');
              },
              child: dataWidget(dataBestWay)
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1),
      ),
    );
  }
}
