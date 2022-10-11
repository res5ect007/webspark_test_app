import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:webspark_test_app/screens/home.dart';
import 'package:webspark_test_app/screens/previev.dart';
import 'package:webspark_test_app/screens/process.dart';
import 'package:webspark_test_app/screens/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.blue
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.blue
          ),
        ),
        getPages: [
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/process', page: () => ProcessScreen()),
          GetPage(name: '/result', page: () => ResultScreen()),
          GetPage(name: '/preview', page: () => PreviewScreen()),
        ]);
  }
}
