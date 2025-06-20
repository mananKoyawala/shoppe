const String _userRoute = "/user";
const String _verifyRoute = "/verify";

class Endpoints {
  static String getEndpoint(EndpointType endpointType) {
    switch (endpointType) {
      case EndpointType.UserLogin:
        return "$_userRoute/login";
      case EndpointType.UserRegister:
        return "$_userRoute/register";
      case EndpointType.VerifyUserEmailOTP:
        return "$_verifyRoute/email-otp";
      case EndpointType.ResendUserEmailOTP:
        return "$_verifyRoute/send-new-otp";
    }
  }
}

enum EndpointType {
  UserLogin,
  UserRegister,
  VerifyUserEmailOTP,
  ResendUserEmailOTP,
}
