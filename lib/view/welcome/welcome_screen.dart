import 'package:flutter/material.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/constants/app_images.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/package/PackageConstants.dart';
import 'package:shoppe/core/package/text.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/welcome_viewmodel.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: SingleChildScrollView(
        child: CP(
          h: 16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizeH(getScreenHeight(context) * .25),

              Container(
                alignment: Alignment.center,
                height: getScreenHeight(context) * .15,
                child: Image.asset(AppImages.app_logo),
              ),
              sizeH40(),
              text(
                text: AppStrings.app_name,
                fontSize: 40,
                fontWeight: 7,
                textColor: theme.cardColor,
              ),
              sizeH15(),
              text(
                textColor: theme.shadowColor,
                textAlign: TextAlign.center,
                text: AppStrings.welcome_message,
                fontSize: 20,
              ),
              sizeH35(),
              simpleButton(
                height: 55,
                context,
                onTap: () => WelcomeViewModel.onLetsGetStartedClicked(context),
                title: text(
                  text: AppStrings.get_start,
                  fontSize: 18,
                  textColor: Colors.white,
                ),
              ),
              sizeH25(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  text(
                    text: AppStrings.already_have_account,
                    fontSize: 18,
                    textColor: theme.shadowColor,
                  ),
                  sizeW10(),
                  iconButton(
                    height: 35,
                    color: AppColors.primaryColor,
                    onTap: () => WelcomeViewModel.onAlreadyHaveAccount(context),
                    icon: Image.asset(AppImages.arrow_button),
                  ),
                ],
              ),
              sizeH50(),
            ],
          ),
        ),
      ),
    );
  }
}
