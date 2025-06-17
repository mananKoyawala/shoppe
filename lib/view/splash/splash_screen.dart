import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_images.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/package/text.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashViewModel>().initializeApp(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: getScreenHeight(context) * .2,
            child: Image.asset(AppImages.app_logo),
          ),
          sizeH30(),
          text(text: AppStrings.app_name, fontSize: 35, fontWeight: 7),
        ],
      ),
    );
  }
}
