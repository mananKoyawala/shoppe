import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/PackageConstants.dart';

Widget textFormField({
  required BuildContext context,
  required ThemeData theme,
  bool? readOnly,
  bool? autofocus,
  TextInputAction? textInputAction,
  InputBorder? border,
  TextEditingController? controller,
  bool? showCursor,
  required String? Function(String?) funValidate,
  String? Function(String?)? onFieldSubmitted,
  Color? cursorColor,
  bool? obsecureText,
  TextInputType? textInputType,
  Function(String)? onChanged,
  int? maxLines,
  int? maxLength,
  TextStyle? textStyle,
  TextStyle? hintStyle,
  TextStyle? labelStyle,
  Widget? prefixIcon,
  Widget? suffixIcon,
  EdgeInsetsGeometry? contentPadding,
  String? labelText,
  String? hintText,
  double? borderRadius,
  Color? fieldColor,
  Color? onClickColor,
  double? borderWidth,
  VoidCallback? onTap,
  Color? backgroundColor,
  bool? onlyNumber,
}) {
  double bottomInsets = MediaQuery.of(context).viewInsets.bottom;
  return TextFormField(
    onFieldSubmitted: onFieldSubmitted,
    readOnly: readOnly ?? false,
    autofocus: autofocus ?? false,
    textInputAction: textInputAction ?? TextInputAction.next,
    showCursor: showCursor,
    controller: controller,
    validator: funValidate,
    onTap: onTap,
    cursorColor: cursorColor ?? black,
    obscureText: obsecureText ?? false,
    keyboardType: textInputType ?? TextInputType.text,
    scrollPadding: EdgeInsets.only(bottom: bottomInsets + 65.0),
    onChanged: onChanged,
    maxLines: maxLines,
    inputFormatters:
        onlyNumber != null && onlyNumber
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
    style:
        textStyle ??
        TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.grey[700],
        ),
    maxLength: maxLength,
    decoration: InputDecoration(
      filled: true,
      fillColor: getBorderColor(theme),
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding:
          contentPadding ??
          const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
      counterText: "",
      labelText: labelText,
      prefixIcon: prefixIcon,
      errorStyle: const TextStyle(fontSize: 14),
      labelStyle:
          labelStyle ??
          TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
      hintText: hintText,
      hintStyle:
          hintStyle ??
          TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey[700],
          ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: getBorderColor(theme)),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: getBorderColor(theme)),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: getBorderColor(theme)),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: getBorderColor(theme)),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: getBorderColor(theme)),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      ),
    ),
  );
}

getBorderColor(ThemeData theme) {
  return theme.brightness == Brightness.light
      ? AppColors.textFieldBgLight
      : AppColors.textFieldBgDark;
}
