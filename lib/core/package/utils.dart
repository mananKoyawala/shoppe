import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
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

String maskEmail(String email) {
  final atIndex = email.indexOf('@');
  if (atIndex <= 3) return email; // If email is too short, return as is

  final firstPart = email.substring(0, 3);
  final domain = email.substring(atIndex);
  return '$firstPart***$domain';
}

String maskPhone(String phone) {
  if (phone.length <= 4) return phone; // Not enough digits to mask

  final first2 = phone.substring(0, 2);
  final last2 = phone.substring(phone.length - 2);
  return '$first2***$last2';
}

Future<void> setUSerPreferenceData(UserProfileModel user_profile) async {
  AppPreferences.setUserId(user_profile.id);
  AppPreferences.setUserFirstName(user_profile.first_name);
  AppPreferences.setUserLastName(user_profile.last_name);
  AppPreferences.setUserFullName(user_profile.full_name);
  AppPreferences.setUserImageUrl(user_profile.image_url);
  AppPreferences.setUserGender(user_profile.gender);
  AppPreferences.setUserCountry(user_profile.country);
  AppPreferences.setUserState(user_profile.state);
  AppPreferences.setUserCity(user_profile.city);
  AppPreferences.setUserAddress(user_profile.address);
  AppPreferences.setUserEmail(user_profile.email);
  AppPreferences.setUserPhoneNumber(user_profile.phone_number);
  AppPreferences.setUserDob(user_profile.dob);
  AppPreferences.setIsMobileVerified(user_profile.is_mobile_verified);
  AppPreferences.setIsEmailVerified(user_profile.is_email_verified);
  AppPreferences.setAccessToken(user_profile.access_token);
  AppPreferences.setUserLogin(true);
}

logoutUser(BuildContext context) {
  // AppPreferences.setIntro(false);
  // AppPreferences.setUserLogin(false);
  AppPreferences.clearAllPreferences();
  context.go("/welcome");
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
