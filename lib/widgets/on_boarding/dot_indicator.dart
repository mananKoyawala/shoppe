import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/onboarding_viewmodel.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    getIndicatorColor() {
      return theme.brightness == Brightness.dark
          ? Colors.amber
          : Colors.grey.shade300;
    }

    return Positioned(
      bottom: getScreenHeight(context) * .32,
      child: Consumer<OnBoardingViewModel>(
        builder: (context, value, child) {
          printDebug("$value");
          return DotsIndicator(
            dotsCount: 3,
            position: value.index.toDouble(),
            decorator: DotsDecorator(
              color: getIndicatorColor(), // Inactive color
              activeColor: theme.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
