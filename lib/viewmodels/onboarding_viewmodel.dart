import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';

class OnBoardingViewModel extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  changeIndex(int value) {
    _index = value;
    notifyListeners();
  }

  onContinue(BuildContext context) async {
    AppPreferences.setIntro(true);
    if (!await AppPreferences.getUserLogin()) {
      if (context.mounted) context.go("/welcome");
    } else {
      if (context.mounted) context.go("/dashboard");
    }
  }
}
