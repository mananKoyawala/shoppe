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
