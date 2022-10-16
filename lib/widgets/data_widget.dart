
import 'package:flutter/material.dart';

Widget dataWidget(List items) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      alignment: Alignment.center,
      child: Text(
        itemsToString(items),
        style: const TextStyle(fontSize: 25),
      ),
    ),
  );
}

itemsToString(List items) {
  String value = '';
  for (int m = 0; m < items.length; m++) {
    value =  '$value${value != '' ?  '->' : ''}(${items[m].value})';
  }
  return value;
}
