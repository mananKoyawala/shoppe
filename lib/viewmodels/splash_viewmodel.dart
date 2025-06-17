import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!await AppPreferences.getIntro()) {
      if (context.mounted) context.go("/onboarding");
    } else if (!await AppPreferences.getUserLogin()) {
      if (context.mounted) context.go("/welcome");
    } else {
      if (context.mounted) context.go("/home");
    }
  }
}
