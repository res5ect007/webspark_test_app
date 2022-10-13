import 'package:flutter/material.dart';

Widget pointWidget(point, exclusionDataList, startPoint, endPoint, bestWayList) {
  Color pointBackgroundColor = getPointBackgroundColor(point, exclusionDataList, startPoint, endPoint, bestWayList);
  Color pointFontColor = getPointFontColor(point, exclusionDataList, startPoint, endPoint, bestWayList);
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      color: pointBackgroundColor
    ),
    child: Text(
      '$point',
      style: TextStyle(fontSize: 20, color: pointFontColor,
    ),
  )
  );
}

getPointFontColor(point, exclusionDataList, startPoint, endPoint, bestWayList) {
  if (exclusionDataList.contains(point) |
      bestWayList.contains(point.toString())) {
    return hexToColor('#FFFFFF');
  } else {
    return hexToColor('#000000');
  }
}

getPointBackgroundColor(point, exclusionDataList, startPoint, endPoint, bestWayList) {
  if (exclusionDataList.contains(point)) {
   return hexToColor('#000000');
  } else if (startPoint.contains(point)) {
    return hexToColor('#64FFDA');
  } else if (endPoint.contains(point)) {
    return hexToColor('#009688');
  } else if (bestWayList.contains(point.toString())) {
    return hexToColor('#4CAF50');
  } else {
    return hexToColor('#FFFFFF');
  }
}

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}