import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/viewmodels/user_profile_viewmodel.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> initializeApp(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    if (!await AppPreferences.getIntro()) {
      if (context.mounted) context.go("/onboarding");
    } else if (!await AppPreferences.getUserLogin()) {
      if (context.mounted) context.go("/welcome");
    } else {
      if (context.mounted) {
        final dataLoaded = await UserProfileViewModel().getUserProfileDetails(
          context,
        );
        if (dataLoaded) {
          if (context.mounted) context.go("/home");
        } else {
          if (context.mounted) context.go("/signin");
        }
      }
    }
  }
}
