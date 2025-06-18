import 'package:flutter/material.dart';
import 'package:shoppe/core/constants/app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    canvasColor: Colors.white,
    cardColor: Colors.black,
    shadowColor: Colors.black45,
  );
}

// use
/*
canvas color
shadow color
hint color
card color
focus color
hover color

 */
// don't use
/*
splashColor
*/
ThemeData darkTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    canvasColor: Colors.white12,
    cardColor: Colors.white,
    shadowColor: Colors.white54,
  );
}
