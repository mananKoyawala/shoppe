extension EmailValidator on String {
  bool get validEmail {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool get validatePassword {
    final passRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d])[A-Za-z\d\S]{6,10}$',
    );
    return passRegex.hasMatch(this);
  }
}

extension OTPValidator on String {
  bool get validateOTP {
    final otpRegex = RegExp(r"^\d{6}$");
    return otpRegex.hasMatch(this);
  }
}

extension PincodeValidator on String {
  bool get validatePincode {
    final pinCodeRegex = RegExp(r"^\d{6}$");
    return pinCodeRegex.hasMatch(this);
  }
}

extension PhoneNumberValidator on String {
  bool get validatePhoneNumber {
    final phoneNumberRegex = RegExp(r"^\d{10}$");
    return phoneNumberRegex.hasMatch(this);
  }
}
