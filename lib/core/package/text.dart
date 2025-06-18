import 'package:flutter/material.dart';
import 'package:shoppe/core/package/utils.dart';
import 'PackageConstants.dart';
import 'RippleEffect/RippleEffectContainer.dart';

Widget text({
  required String text,
  Color? textColor,
  int? fontWeight,
  required double fontSize,
  TextAlign? textAlign,
  String? fontFamily,
  dynamic decoration,
  TextOverflow? overflow,
  int? maxLines,
  bool? softWrap,
}) {
  return Text(
    text,
    softWrap: softWrap,
    maxLines: maxLines,
    overflow: overflow,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: getfontWeight(fontWeight),
      color: textColor ?? Colors.black,
      fontFamily: fontFamily,
      decoration: decoration,
    ),
  );
}

Widget simpleButton(
  BuildContext context, {
  double? height,
  double? width,
  double? prefixIconGap,
  double? suffixIconGap,
  Color? backgroundColor,
  double? borderRadius,
  Widget? title,
  required VoidCallback onTap,
  BoxBorder? border,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return ClickEffect(
    onTap: onTap,
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
    child: Container(
      height: height ?? 50,
      width: width ?? getScreenWidth(context),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        border: border,
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixIcon ?? Container(),
          SizedBox(width: prefixIconGap ?? 0),
          title ??
              text(
                text: 'Click here',
                fontSize: 16,
                textColor: white,
                fontWeight: 5,
              ),
          SizedBox(width: suffixIconGap ?? 0),
          suffixIcon ?? Container(),
        ],
      ),
    ),
  );
}

// icon button
Widget iconButton({
  required void Function()? onTap,
  double? height,
  Widget? icon,
  Color? color,
  radius,
}) {
  return ClickEffect(
    onTap: onTap,
    borderRadius: BorderRadius.circular(radius ?? 30),
    child: Container(
      color: color,
      height: height ?? 50,
      width: height ?? 50,
      child: icon ?? const Icon(Icons.settings),
    ),
  );
}

FontWeight getfontWeight(int? i) {
  switch (i) {
    case 2:
      return FontWeight.w200;
    case 3:
      return FontWeight.w300;
    case 4:
      return FontWeight.w400;
    case 5:
      return FontWeight.w500;
    case 6:
      return FontWeight.w600;
    case 7:
      return FontWeight.w700;
    default:
      return FontWeight.normal;
  }
}
