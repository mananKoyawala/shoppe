import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

STATUS_BAR_TRANSPERANT() {
  //BD 08-09-2022
  //SET APP STATUS BAR TRANSPERANT FOR ANDROID
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness:
            Brightness.light /* set Status bar icon color in iOS. */,
      ),
    );
  }
}
