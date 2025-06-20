import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/PackageConstants.dart';

class AppLoader {
  // * show loader
  static showLoader() {
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 1)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50
      ..radius = 10.0
      ..indicatorColor = AppColors.primaryColor
      ..userInteractions = false
      ..dismissOnTap = false
      ..textColor = transparent
      ..backgroundColor = white
      ..animationStyle = EasyLoadingAnimationStyle.offset
      ..maskType = EasyLoadingMaskType.black;
    return EasyLoading.show();
  }

  // * dismiss the loader
  static dismissLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
