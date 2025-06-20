import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoppe/core/constants/app_images.dart';

class FillBackground extends StatelessWidget {
  const FillBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: SvgPicture.asset(AppImages.app_bg, fit: BoxFit.fill),
    );
  }
}
