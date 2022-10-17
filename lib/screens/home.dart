import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/data_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _url = '';
  final TextEditingController urlController = TextEditingController();
  final DataController dataController = Get.put(DataController());

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _loadUrl();
  }

  _loadUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _url = (prefs.getString('URL') ?? '');
      urlController.text = _url.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home screen')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text('Set valid API base URL in order to continue'),
            ),
            TextFormField(
              controller: urlController,
              decoration: const InputDecoration(
                  labelText: 'Please enter URL', suffixIcon: Icon(Icons.api)),
            ),
            const Spacer(),
            TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('URL', urlController.text.trim());
                  Get.toNamed('/process');
                  dataController.fetchData();
                },
            style:  ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
            ),
                child:  const Text(
                  'Start counting process',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                ),
            )
          ],
        ),
      ),
    );
  }
}
