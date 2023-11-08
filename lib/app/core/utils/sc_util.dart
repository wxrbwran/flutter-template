import 'package:flutter/material.dart';

double withSCWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double withSCHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

EdgeInsets withSCPadding(BuildContext context) {
  return MediaQuery.of(context).padding;
}

double withWidgetWidth(BuildContext context) {
  RenderBox? box = context.findRenderObject() as RenderBox;
  return box.size.width;
}

double withWidgetHeight(BuildContext context) {
  RenderBox? box = context.findRenderObject() as RenderBox;
  return box.size.height;
}

Offset withWidgetPosition(BuildContext context) {
  RenderBox box = context.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero);
}
