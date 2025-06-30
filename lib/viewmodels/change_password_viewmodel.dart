import 'package:go_router/go_router.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/services/verify_otp_service.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final passwordCtr = TextEditingController();
  final confirmPwdCtr = TextEditingController();
  bool isObsecure = true;
  bool isObsecureConPwd = true;

  onChangePassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AppLoader.showLoader();
      String new_password = passwordCtr.text.trim();
      String email = AppPreferences.getUserEmail();

      final response = await VerifyOtpService.resendEmailOTP(email);
      if (response != null && response.statusCode == 200) {
        await AppPreferences.setTempAccessToken(
          response.data["data"]["access_token"],
        );
        toast("OTP sent");
        if (context.mounted) {
          context.push(
            "/verify",
            extra: {
              'isEmailVerification': true,
              'verificationPlatfrom': email,
              'isChangePassword': true,
              'new_password': new_password,
            },
          );
        }
      } else {
        toast("Unable to change password");
      }
      AppLoader.dismissLoader();
    }
  }

  onCancel(BuildContext context) {
    context.pop();
    resetAll();
  }

  validatePassword(String? val) {
    if (val == null || !val.validatePassword) {
      return AppStrings.err_password;
    }
    return null;
  }

  validateConfirmPassword(String? val) {
    if (passwordCtr.text.isEmpty) {
      return null;
    } else if (val == null || val != passwordCtr.text) {
      return AppStrings.err_confrim_password;
    }
    return null;
  }

  toggleObsecure() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  toggleObsecureConPwd() {
    isObsecureConPwd = !isObsecureConPwd;
    notifyListeners();
  }

  void resetAll() {
    passwordCtr.clear();
    confirmPwdCtr.clear();
    isObsecure = true;
    isObsecureConPwd = true;
  }
}
