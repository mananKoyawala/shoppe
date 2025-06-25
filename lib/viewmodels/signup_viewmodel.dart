import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shoppe/core/constants/loader.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/services/register_service.dart';

class SignupViewModel extends ChangeNotifier {
  String? selectedGender;
  final List<String> genders = ['Male', 'Female', 'Other'];

  changeValue(String? value) {
    selectedGender = value;
    notifyListeners();
  }

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
  final passwordCtr = TextEditingController();
  final confirmPwdCtr = TextEditingController();
  bool isObsecure = true;
  bool isObsecureConPwd = true;

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default to today
      firstDate: DateTime(
        2000,
        1,
        1,
      ), // Adjust as needed (earliest selectable date)
      lastDate: DateTime.now(), // Restrict to today (cannot pick future dates)
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobCtr.text = formattedDate; // Set formatted date to TextField
    }
  }

  void onNext(BuildContext context) async {
    if (formKey.currentState!.validate()) {
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
      String password = passwordCtr.text.trim();

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
      printDebug("Password $password");

      AppLoader.showLoader();

      final response = await RegisterService.userRegister(
        firstName,
        lastName,
        gender,
        country,
        state,
        city,
        address,
        email,
        phoneNumber,
        dob,
        pincode,
        password,
      );

      if (response != null) {
        if (response.statusCode == 200) {
          toast("Please verify your email");
          printDebug(response.data["data"]["access_token"]);
          await AppPreferences.setTempAccessToken(
            response.data["data"]["access_token"],
          );
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

        if (response.statusCode == 409) {
          printDebug(">>> Already is use");
        }
      }

      AppLoader.dismissLoader();
    }
  }

  void onCancel(BuildContext context) {
    context.pop();
    resetAll();
  }

  void resetAll() {
    isObsecure = true;
    isObsecureConPwd = true;
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
    passwordCtr.clear();
    confirmPwdCtr.clear();
  }

  // * validation

  fieldIsRequired(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.err_field_required;
    }
    return null;
  }

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

  validateConfirmPassword(String? val) {
    if (passwordCtr.text.isEmpty) {
      return null;
    } else if (val == null || val != passwordCtr.text) {
      return AppStrings.err_confrim_password;
    }
    return null;
  }

  validatePincode(String? val) {
    if (val == null || !val.validatePincode) {
      return AppStrings.err_pin_code;
    }
    return null;
  }

  validatePhonenumber(String? val) {
    if (val == null || !val.validatePhoneNumber) {
      return AppStrings.err_phone_number;
    }
    return null;
  }

  validateGenderSelected(String? val) {
    if (val == null || val.isEmpty) {
      return AppStrings.err_select_gender;
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
}
