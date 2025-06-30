import 'package:dio/src/response.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
import 'package:shoppe/services/user_profile_service.dart';
import 'package:shoppe/services/verify_otp_service.dart';
import 'package:shoppe/viewmodels/change_password_viewmodel.dart';
import 'package:shoppe/viewmodels/sigin_viewmodel.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final otpCtr = TextEditingController();

  validateOTP(String? val) {
    if (val == null || !val.validateOTP) {
      return AppStrings.err_otp;
    }
    return null;
  }

  String getFormattedOTPSent(
    bool isEmailVerification,
    String verificationPlatfrom,
  ) {
    if (isEmailVerification) {
      return "We have sent OTP on ${maskEmail(verificationPlatfrom)}";
    }
    return "We have sent OTP on ${maskPhone(verificationPlatfrom)}";
  }

  void onContinue(
    BuildContext context,
    bool isEmailVerification,
    String verificationPlatfrom,
    bool isChangePassword,
    String new_password,
  ) async {
    printDebug("change password $isChangePassword password $new_password");
    if (formKey.currentState!.validate()) {
      AppLoader.showLoader();
      final Response? response;
      if (isChangePassword) {
        final res = await UserProfileService.changePassword(
          otpCtr.text.trim(),
          new_password,
        );
        if (res != null && res.statusCode == 200) {
          if (res.data["data"]["user_change_password"]) {
            toast("Password is updated");
            resetAll();
            ChangePasswordViewModel().resetAll();
            resetAll();
            if (context.mounted) {
              context.pop();
              context.pop();
            }
          } else {
            resetAll();
            if (context.mounted) {
              context.pop();
            }
            toast("Failed to update password");
          }
        }
      } else {
        if (isEmailVerification) {
          response = await VerifyOtpService.verifyEmailOTP(otpCtr.text.trim());
        } else {
          response = await VerifyOtpService.verifyPhoneOTP(otpCtr.text.trim());
        }
        if (response?.statusCode == 200) {
          if (response?.data["data"]["otp_verification"]) {
            isEmailVerification
                ? toast("Email is verified")
                : toast("Phone number is verified");
            UserProfileModel user_profile = UserProfileModel.fromJson(
              response?.data["data"]["user_profile"],
            );
            await setUserPreferenceData(user_profile);
            resetAll();
            // clear all after user email verired while login
            if (context.mounted) {
              context.read<SigninViewModel>().resetAll();
              context.go("/dashboard");
            }
          }
        }
      }
      AppLoader.dismissLoader();
    }
  }

  void onResendOTP(
    bool isEmailVerification,
    String platform, {
    bool isLoginEmailVerification = false,
  }) async {
    otpCtr.clear();

    if (!isLoginEmailVerification) AppLoader.showLoader();
    final Response? response;
    if (isEmailVerification) {
      response = await VerifyOtpService.resendEmailOTP(platform.trim());
    } else {
      response = await VerifyOtpService.resendPhoneOTP(platform.trim());
    }
    if (response?.statusCode == 200) {
      await AppPreferences.setTempAccessToken(
        response?.data["data"]["access_token"],
      );
      toast("OTP sent");
      printDebug(await AppPreferences.getTempAccessToken());
    }
    if (!isLoginEmailVerification) AppLoader.dismissLoader();
  }

  void resetAll() {
    otpCtr.clear();
  }
}
