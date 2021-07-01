import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double resizedHeight(double inputHeight) {
  var screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use

  return (inputHeight / 1920.0) * screenHeight;
}

// Get the proportionate height as per screen size
double resizedWidth(double inputWidth) {
  var screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use

  return (inputWidth / 1080.0) * screenWidth;
}
