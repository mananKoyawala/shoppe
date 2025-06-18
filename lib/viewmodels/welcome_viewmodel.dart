import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeViewModel {
  static onLetsGetStartedClicked(BuildContext context) {
    context.push("/signup");
  }

  static onAlreadyHaveAccount(BuildContext context) {
    context.push("/signin");
  }
}
