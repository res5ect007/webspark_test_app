import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../controllers/data_controller.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Process screen'),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back),
            )),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Center(
                    child: Column(
                      children: [ dataController.isLoading.isTrue ? const Text(
                          'Data is calculating...', style: TextStyle(
                          fontSize: 20), textAlign: TextAlign.center) :
                      const Text(
                        'All calculations has finished, you can send your results to server ',
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                                radius: 70,
                                lineWidth: 5,
                                percent: dataController.loadingPercent.value,
                                progressColor: Colors.blue,
                                backgroundColor: Colors.blue.shade100,
                                circularStrokeCap: CircularStrokeCap.round,
                                center: Text('${dataController.loadingPercent.value *
                                    100}%', style: const TextStyle(fontSize: 22),),
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child:
                  dataController.isLoading.isTrue ? const SizedBox() :
                  TextButton(
                    onPressed: dataController.isSending.isTrue ? null : () {
                      dataController.sendData();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue)
                    ),
                    child: const Text(
                      'Send results to server',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          }),
        )
    );
  }
}
