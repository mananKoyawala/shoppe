import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/package/text.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/models/on_boarding_model.dart';
import 'package:shoppe/viewmodels/onboarding_viewmodel.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key, required this.pages});
  final List<OnBoardingModel> pages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PageView.builder(
      onPageChanged: (value) {
        // context.read<DotIndicatorCubit>().changeIndicator(value);
        context.read<OnBoardingViewModel>().changeIndex(value);
      },
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: getScreenHeight(context) / 4,
              child: Image.asset(pages[index].image),
            ),
            Column(
              children: [
                text(
                  text: pages[index].title,
                  fontSize: 26,
                  textColor: theme.cardColor,
                  textAlign: TextAlign.center,
                  fontWeight: 5,
                ),
                sizeH25(),
                text(
                  text: pages[index].body,
                  fontSize: 18,
                  textColor: theme.cardColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
