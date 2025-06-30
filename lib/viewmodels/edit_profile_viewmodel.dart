import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/models/user_profile_model.dart';
import 'package:shoppe/services/user_profile_service.dart';
import 'package:shoppe/services/verify_otp_service.dart';

class EditProfileViewModel extends ChangeNotifier {
  String? selectedGender;
  final List<String> genders = ['Male', 'Female', 'Other'];

  changeValue(String? value) {
    selectedGender = value;
    notifyListeners();
  }

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      // initialDate: DateTime.now(), // Default to today
      firstDate: DateTime(
        2000,
        1,
        1,
      ), // Adjust as needed (earliest selectable date)
      lastDate: DateTime(
        2009,
        12,
        31,
      ), // Restrict to today (cannot pick future dates)
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobCtr.text = formattedDate; // Set formatted date to TextField
    }
  }

  final group1 = GlobalKey<FormState>();
  final group2 = GlobalKey<FormState>();
  final group3 = GlobalKey<FormState>();
  final group4 = GlobalKey<FormState>();
  final group5 = GlobalKey<FormState>();
  final group6 = GlobalKey<FormState>();

  bool group1Flag = false;
  bool group2Flag = false;
  bool group3Flag = false;
  bool group4Flag = false;
  bool group5Flag = false;
  bool group6Flag = false;

  final formKey = GlobalKey<FormState>();
  final firstNameCtr = TextEditingController();
  final lastNameCtr = TextEditingController();
  final countryCtr = TextEditingController();
  final stateCtr = TextEditingController();
  final cityCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final phoneNumberCtr = TextEditingController();
  final dobCtr = TextEditingController();
  final pincodeCtr = TextEditingController();

  onCancel(BuildContext context) async {
    context.pop();
  }

  onUpdateClicked(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AppLoader.showLoader();

      String firstName = firstNameCtr.text.trim();
      String lastName = lastNameCtr.text.trim();
      String gender = selectedGender!;
      String country = countryCtr.text.trim();
      String state = stateCtr.text.trim();
      String city = cityCtr.text.trim();
      String address = addressCtr.text.trim();
      String email = emailCtr.text.trim().toLowerCase();
      String phoneNumber = phoneNumberCtr.text.trim();
      String dob = dobCtr.text.trim();
      String pincode = pincodeCtr.text.trim();

      printDebug("First name $firstName");
      printDebug("Last name $lastName");
      printDebug("Gender $gender");
      printDebug("Country $country");
      printDebug("State $state");
      printDebug("City $city");
      printDebug("Address $address");
      printDebug("Email $email");
      printDebug("Phone number $phoneNumber");
      printDebug("Dob $dob");
      printDebug("Pincode $pincode");

      final response = await UserProfileService.editUserProfileData(
        firstName,
        lastName,
        gender,
        country,
        state,
        city,
        address,
        dob,
        pincode,
      );
      printDebug("1");
      if (response != null && response.statusCode == 200) {
        printDebug("2");
        if (response.data["data"]["user_updated"]) {
          printDebug("3");
          UserProfileModel user_profile = UserProfileModel.fromJson(
            response.data["data"]["user_profile"],
          );
          printDebug("4");
          printDebug(user_profile.gender);
          await setUserPreferenceData(user_profile, setAccessToken: false);
          printDebug("5");
          toast("Profile upadated");
          if (context.mounted) context.pop();
        } else {
          printDebug("6");
          toast("Unable to update profile");
        }
        printDebug("7");
      }
      printDebug("8");

      AppLoader.dismissLoader();
    } else {
      resetFlags();
    }
  }

  onVerifyEmail(BuildContext context) async {
    AppLoader.showLoader();
    final response = await VerifyOtpService.resendEmailOTP(
      emailCtr.text.trim(),
    );

    if (response?.statusCode == 200) {
      await AppPreferences.setTempAccessToken(
        response?.data["data"]["access_token"],
      );

      printDebug(await AppPreferences.getTempAccessToken());
      if (context.mounted) {
        context.push(
          "/verify",
          extra: {
            'isEmailVerification': true,
            'verificationPlatfrom': emailCtr.text.trim(),
            'isChangePassword': false,
            'new_password': '',
          },
        );
        toast("OTP sent");
      }
    }
    AppLoader.dismissLoader();
  }

  onVerifyMobile(BuildContext context) async {
    AppLoader.showLoader();
    final response = await VerifyOtpService.resendPhoneOTP(
      phoneNumberCtr.text.trim(),
    );

    if (response?.statusCode == 200) {
      await AppPreferences.setTempAccessToken(
        response?.data["data"]["access_token"],
      );

      printDebug(await AppPreferences.getTempAccessToken());
      if (context.mounted) {
        context.push(
          "/verify",
          extra: {
            'isEmailVerification': false,
            'verificationPlatfrom': phoneNumberCtr.text.trim(),
            'isChangePassword': false,
            'new_password': '',
          },
        );
        toast("OTP sent");
      }
    }
    AppLoader.dismissLoader();
  }

  void setupUserData() {
    firstNameCtr.text = AppPreferences.getUserFirstName();
    lastNameCtr.text = AppPreferences.getUserLastName();
    countryCtr.text = AppPreferences.getUserCountry();
    stateCtr.text = AppPreferences.getUserState();
    cityCtr.text = AppPreferences.getUserCity();
    addressCtr.text = AppPreferences.getUserAddress();
    emailCtr.text = AppPreferences.getUserEmail();
    phoneNumberCtr.text = AppPreferences.getUserPhoneNumber();
    dobCtr.text = AppPreferences.getUserDob();
    pincodeCtr.text = AppPreferences.getUserPinCode();
  }

  fieldIsRequired(String? val, VoidCallback fn) {
    if (val == null || val.isEmpty) {
      fn();
      return AppStrings.err_field_required;
    }
    return null;
  }

  validateEmail(String? val) {
    if (val == null || !val.validEmail) {
      scrollToGroup2();
      return AppStrings.err_email;
    }
    return null;
  }

  validatePincode(String? val) {
    if (val == null || !val.validatePincode) {
      scrollToGroup6();
      return AppStrings.err_pin_code;
    }
    return null;
  }

  validatePhonenumber(String? val) {
    if (val == null || !val.validatePhoneNumber) {
      scrollToGroup3();
      return AppStrings.err_phone_number;
    }
    return null;
  }

  validateGenderSelected(String? val) {
    if (val == null || val.isEmpty) {
      scrollToGroup3();
      return AppStrings.err_select_gender;
    }
    return null;
  }

  void resetAll() {
    selectedGender = null;
    firstNameCtr.clear();
    lastNameCtr.clear();
    countryCtr.clear();
    stateCtr.clear();
    cityCtr.clear();
    addressCtr.clear();
    emailCtr.clear();
    phoneNumberCtr.clear();
    dobCtr.clear();
    pincodeCtr.clear();
  }

  void scrollToGroup1() {
    group1Flag = true;
    if (group1Flag &&
        !group2Flag &&
        !group3Flag &&
        !group4Flag &&
        !group5Flag &&
        !group6Flag) {
      scroll(group1);
    }
  }

  void scrollToGroup2() {
    group2Flag = true;
    if (!group1Flag &&
        group2Flag &&
        !group3Flag &&
        !group4Flag &&
        !group5Flag &&
        !group6Flag) {
      scroll(group2);
    }
  }

  void scrollToGroup3() {
    group3Flag = true;
    if (!group1Flag &&
        !group2Flag &&
        group3Flag &&
        !group4Flag &&
        !group5Flag &&
        !group6Flag) {
      scroll(group3);
    }
  }

  void scrollToGroup4() {
    group4Flag = true;
    if (!group1Flag &&
        !group2Flag &&
        !group3Flag &&
        group4Flag &&
        !group5Flag &&
        !group6Flag) {
      scroll(group4);
    }
  }

  void scrollToGroup5() {
    group5Flag = true;
    if (!group1Flag &&
        !group2Flag &&
        !group3Flag &&
        !group4Flag &&
        group5Flag &&
        !group6Flag) {
      scroll(group5);
    }
  }

  void scrollToGroup6() {
    group6Flag = true;
    if (!group1Flag &&
        !group2Flag &&
        !group3Flag &&
        !group4Flag &&
        !group5Flag &&
        group6Flag) {
      scroll(group6);
    }
  }

  scroll(GlobalKey<FormState> key) {
    Future.delayed(Duration(milliseconds: 200), () {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 200),
        alignment: 0,
        curve: Curves.easeInOut,
      );
    });
  }

  void resetFlags() {
    group1Flag = false;
    group2Flag = false;
    group3Flag = false;
    group4Flag = false;
    group5Flag = false;
    group6Flag = false;
  }
}
