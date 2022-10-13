import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [ dataController.isLoading.isTrue ? const Text(
                      'Data is calculating...', style: TextStyle(fontSize: 20)) :
                    const Text(
                        'All calculations has finished, you can send your results to server',
                        style: TextStyle(fontSize: 17)),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('${dataController.loadingPercent.value}%', style: const TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child:
                dataController.isLoading.isTrue ? const SizedBox() :
                TextButton(
                  onPressed: dataController.isSending.isTrue ? null : () {
                    //dataController.sendData();
                    Get.toNamed('/result');
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
          ),
        );
      }),
    );
  }
}
