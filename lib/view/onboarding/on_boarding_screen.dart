import 'package:flutter/material.dart';
import 'package:shoppe/core/constants/app_images.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/models/on_boarding_model.dart';
import 'package:shoppe/widgets/on_boarding/body.dart';
import 'package:shoppe/widgets/on_boarding/dot_indicator.dart';
import 'package:shoppe/widgets/on_boarding/page_view.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  List<OnBoardingModel> pages = [
    OnBoardingModel(
      title: AppStrings.onboarding_title_1,
      body: AppStrings.onboarding_body_1,
      image: AppImages.onboarding_asset_1,
      backgroundImage: AppImages.onboarding_bg_1,
    ),
    OnBoardingModel(
      title: AppStrings.onboarding_title_2,
      body: AppStrings.onboarding_body_2,
      image: AppImages.onboarding_asset_2,
      backgroundImage: AppImages.onboarding_bg_2,
    ),
    OnBoardingModel(
      title: AppStrings.onboarding_title_3,
      body: AppStrings.onboarding_body_3,
      image: AppImages.onboarding_asset_3,
      backgroundImage: AppImages.onboarding_bg_2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageViewWidget(
                    pages: pages,
                  ), // pageview.builder for multiple pages
                  DotIndicator(), // shows page indicator
                ],
              ),
            ),
            CP(h: 16, child: Body()), // shows title and sub-title
            sizeH10(),
          ],
        ),
      ),
    );
  }
}
