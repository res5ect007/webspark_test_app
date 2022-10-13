import 'package:flutter/material.dart';

Widget dataWidget(String item) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      item,
      style: const TextStyle(fontSize: 20),
    ),
  );
}