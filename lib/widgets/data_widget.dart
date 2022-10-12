import 'package:flutter/material.dart';

Widget dataWidget(List item) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      '$item[0][0]',
      style: const TextStyle(fontSize: 20),
    ),
  );
}