import 'package:flutter/material.dart';

Widget pointWidget(point, exclusionList, startPoint, endPoint, dataBestWay) {
  Color pointBackgroundColor = getPointBackgroundColor(point, exclusionList, startPoint, endPoint, dataBestWay);
  Color pointFontColor = getPointFontColor(point, exclusionList, startPoint, endPoint, dataBestWay);
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      color: pointBackgroundColor
    ),
    child: Text(
      '${point.value}',
      style: TextStyle(fontSize: 20, color: pointFontColor,
    ),
  )
  );
}

getPointFontColor(point, exclusionList, startPoint, endPoint, bestWayList) {
  if (exclusionList.contains(point) | bestWayList.contains(point)) {
    return hexToColor('#FFFFFF');
  } else {
    return hexToColor('#000000');
  }
}

getPointBackgroundColor(point, exclusionList, startPoint, endPoint, bestWayList) {
  if (exclusionList.contains(point)) {
   return hexToColor('#000000');
  } else if (startPoint == point) {
    return hexToColor('#64FFDA');
  } else if (endPoint == point) {
    return hexToColor('#009688');
  } else if (bestWayList.contains(point)) {
    return hexToColor('#4CAF50');
  } else {
    return hexToColor('#FFFFFF');
  }
}

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

itemsToString(List items) {
  String value = '';
  for (int m = 0; m < items.length; m++) {
    value =  '$value${value != '' ?  '->' : ''}(${items[m].value})';
  }
  return value;
}
