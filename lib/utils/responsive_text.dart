
import 'package:flutter/material.dart';

double getResponsiveText(BuildContext context, double fontSize) {
  double scaleFactor = fontSize * getScaleFactor(context);
  double lowerLimit = fontSize * .80;
  double upperLimit = fontSize * 1.2;
  return scaleFactor.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
