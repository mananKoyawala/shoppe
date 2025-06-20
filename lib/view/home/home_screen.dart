import 'package:flutter/material.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/text.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: text(text: "Home screen, ${getUserName()}", fontSize: 30),
          ),
          sizeH20(),
          simpleButton(
            backgroundColor: AppColors.primaryColor,
            width: 150,
            context,
            onTap: () {
              logoutUser(context);
            },
            title: text(text: "Logout", fontSize: 18, textColor: Colors.white),
          ),
        ],
      ),
    );
  }

  getUserName() {
    return AppPreferences.getUserFullName();
  }
}
