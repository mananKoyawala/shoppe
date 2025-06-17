import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/navigatorKey.dart';
import 'PackageConstants.dart';
import 'package:url_launcher/url_launcher.dart';

Widget dropDownMenu({
  required BuildContext context,
  required List<String> items,
  required Function(String) onSelected,
  Color? color,
  Color? textColor,
}) {
  return Theme(
    data: Theme.of(context).copyWith(
      popupMenuTheme: PopupMenuThemeData(color: color ?? Colors.green),
    ),
    child: PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: textColor ?? white,
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList();
      },
    ),
  );
}

radius(double d) {
  return BorderRadius.circular(d);
}

unfocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

infinity() {
  return double.infinity;
}

visibility() {
  return MediaQuery.of(navigatorContext).viewInsets.bottom == 0;
}

// H -> Height
sizeH5() {
  return const SizedBox(height: 5);
}

sizeH10() {
  return const SizedBox(height: 10);
}

sizeH15() {
  return const SizedBox(height: 15);
}

sizeH20() {
  return const SizedBox(height: 20);
}

sizeH25() {
  return const SizedBox(height: 25);
}

sizeH30() {
  return const SizedBox(height: 30);
}

sizeH35() {
  return const SizedBox(height: 35);
}

sizeH40() {
  return const SizedBox(height: 40);
}

sizeH45() {
  return const SizedBox(height: 45);
}

sizeH50() {
  return const SizedBox(height: 50);
}

// W - Width

sizeW5() {
  return const SizedBox(width: 5);
}

sizeW10() {
  return const SizedBox(width: 10);
}

sizeW15() {
  return const SizedBox(width: 15);
}

sizeW20() {
  return const SizedBox(width: 20);
}

sizeW25() {
  return const SizedBox(width: 25);
}

sizeW30() {
  return const SizedBox(width: 30);
}

sizeW35() {
  return const SizedBox(width: 35);
}

sizeW40() {
  return const SizedBox(width: 40);
}

sizeW45() {
  return const SizedBox(width: 45);
}

sizeW50() {
  return const SizedBox(width: 50);
}

sizeH(double h) {
  return SizedBox(height: h);
}

sizeW(double w) {
  return SizedBox(width: w);
}

printDebug(Object? s) {
  if (kDebugMode) {
    print(">>> $s");
  }
}

launchURL(Uri url) async {
  if (!await launchUrl(url)) {
    toast("Failed to lauch url");
  }
}

class CustomScroll extends StatelessWidget {
  const CustomScroll({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [SliverFillRemaining(hasScrollBody: false, child: child)],
    );
  }
}
