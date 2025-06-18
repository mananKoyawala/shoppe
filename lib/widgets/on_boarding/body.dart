import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/package/text.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/onboarding_viewmodel.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.primaryColor,
      width: getScreenWidth(context),
      height: 65,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: simpleButton(
              context,
              height: 50,
              onTap: () {
                context.read<OnBoardingViewModel>().onContinue(context);
              },
              backgroundColor: theme.primaryColor,
              title: text(
                text: AppStrings.let_continue,
                fontSize: 18,
                fontWeight: 7,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
