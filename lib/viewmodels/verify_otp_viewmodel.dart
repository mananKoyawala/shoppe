import 'package:go_router/go_router.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
import 'package:shoppe/services/verify_otp_service.dart';

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
  ) async {
    if (formKey.currentState!.validate()) {
      AppLoader.showLoader();
      final response = await VerifyOtpService.verifyOTP(otpCtr.text.trim());

      if (response?.statusCode == 200) {
        if (response?.data["data"]["otp_verification"]) {
          toast("Email is verified");
          UserProfileModel user_profile = UserProfileModel.fromJson(
            response?.data["data"]["user_profile"],
          );
          await setUserPreferenceData(user_profile);
          if (context.mounted) context.go("/home");
        }
      }
      AppLoader.dismissLoader();
    }
  }

  void onResendOTP(email) async {
    otpCtr.clear();
    AppLoader.showLoader();
    final response = await VerifyOtpService.resendEmailOTP(email);
    if (response?.statusCode == 200) {
      await AppPreferences.setTempAccessToken(
        response?.data["data"]["access_token"],
      );
      printDebug(await AppPreferences.getTempAccessToken());
    }
    AppLoader.dismissLoader();
  }

  void resetAll() {
    otpCtr.clear();
  }
}
