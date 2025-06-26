import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/PackageConstants.dart';
import 'package:shoppe/core/package/validation.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_login_model.dart';
import 'package:shoppe/services/login_service.dart';
import 'package:shoppe/viewmodels/verify_otp_viewmodel.dart';

class SigninViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();
  bool isObsecure = true;

  validateEmail(String? val) {
    if (val == null || !val.validEmail) {
      return AppStrings.err_email;
    }
    return null;
  }

  validatePassword(String? val) {
    if (val == null || !val.validatePassword) {
      return AppStrings.err_password;
    }
    return null;
  }

  toggleObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  void onNext(BuildContext context) async {
    AppLoader.showLoader();
    if (formKey.currentState!.validate()) {
      final email = emailCtr.text.toLowerCase().trim();
      final password = passCtr.text.trim();

      final response = await LoginService.userLogin(email, password);

      if (response != null) {
        // Successfully logged in
        if (response.statusCode == 200) {
          if (context.mounted) _afterLoginProcess(context, response);
          resetAll();
        }

        // User email is not verified.
        if (response.statusCode == 403) {
          VerifyOtpViewModel().onResendOTP(email);

          if (context.mounted) {
            context.push(
              "/verify",
              extra: {
                'isEmailVerification': true,
                'verificationPlatfrom': email,
              },
            );
          }
        }
      }
    }

    AppLoader.dismissLoader();
  }

  _afterLoginProcess(BuildContext context, response) async {
    try {
      final UserLoginModel userData = UserLoginModel.fromJson(
        response.data["data"],
      );
      await _setPreferenceData(userData);
      toast(AppStrings.user_login_success);
      if (context.mounted) context.go("/dashboard");
      printDebug(userData.user_profile.access_token);
    } catch (e) {
      toast(AppStrings.unable_to_login);
      printDebug(e.toString());
    }
    AppLoader.dismissLoader();
  }

  _setPreferenceData(UserLoginModel userData) {
    AppPreferences.setUserId(userData.user_profile.id);
    AppPreferences.setUserFirstName(userData.user_profile.first_name);
    AppPreferences.setUserLastName(userData.user_profile.last_name);
    AppPreferences.setUserFullName(userData.user_profile.full_name);
    AppPreferences.setUserImageUrl(userData.user_profile.image_url);
    AppPreferences.setUserGender(userData.user_profile.gender);
    AppPreferences.setUserCountry(userData.user_profile.country);
    AppPreferences.setUserState(userData.user_profile.state);
    AppPreferences.setUserCity(userData.user_profile.city);
    AppPreferences.setUserAddress(userData.user_profile.address);
    AppPreferences.setUserEmail(userData.user_profile.email);
    AppPreferences.setUserPhoneNumber(userData.user_profile.phone_number);
    AppPreferences.setUserDob(userData.user_profile.dob);
    AppPreferences.setIsMobileVerified(
      userData.user_profile.is_mobile_verified,
    );
    AppPreferences.setIsEmailVerified(userData.user_profile.is_email_verified);
    AppPreferences.setAccessToken(userData.user_profile.access_token);
    AppPreferences.setUserLogin(true);
  }

  void onCancel(BuildContext context) {
    resetAll();
    context.pop();
  }

  void resetAll() {
    emailCtr.clear();
    passCtr.clear();
    isObsecure = true;
  }
}
