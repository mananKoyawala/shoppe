import 'dart:io';

import 'package:flutter/services.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    DateTime? _lastBackPressed;
    return DismissLoader(
      canPop: false,
      onBack: () {
        if (_lastBackPressed == null ||
            DateTime.now().difference(_lastBackPressed!) >
                const Duration(seconds: 2)) {
          // Notify user to press back again within the time limit
          toast("Press back again to exit");
          _lastBackPressed = DateTime.now();
        } else {
          // If back is pressed again within 5 seconds, allow navigation
          if (Platform.isAndroid) {
            // Exit app for Android
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            // Exit app for iOS
            exit(0);
          }
        }
      },
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: Container(
          alignment: Alignment.center,
          child: text(
            text: "Home Screen",
            fontSize: 20,
            textColor: AppColors.primaryColor,
            fontWeight: 5,
          ),
        ),
      ),
    );
  }
}
