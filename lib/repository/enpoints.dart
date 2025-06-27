const String _userRoute = "/user";
const String _verifyRoute = "/verify";

class Endpoints {
  static String getEndpoint(EndpointType endpointType) {
    switch (endpointType) {
      case EndpointType.UserLogin:
        return "$_userRoute/login";
      case EndpointType.UserRegister:
        return "$_userRoute/register";
      case EndpointType.UserProfileDetails:
        return "$_userRoute/profile";
      case EndpointType.VerifyUserEmailOTP:
        return "$_verifyRoute/email-otp";
      case EndpointType.VerifyUserPhoneOTP:
        return "$_verifyRoute/sms-otp";
      case EndpointType.ResendUserEmailOTP:
        return "$_verifyRoute/send-new-otp";
      case EndpointType.ResendUserPhoneOTP:
        return "$_verifyRoute/send-sms-otp";
      case EndpointType.UpdateUserProfile:
        return "$_userRoute/update-profile";
      case EndpointType.ChangePassword:
        return "$_userRoute/change-password";
      case EndpointType.UpdateUserProfileImage:
        return "$_userRoute/upload-image";
      case EndpointType.DeleteUser:
        return "$_userRoute/delete";
    }
  }
}

enum EndpointType {
  UserLogin,
  UserRegister,
  UserProfileDetails,
  VerifyUserEmailOTP,
  VerifyUserPhoneOTP,
  ResendUserEmailOTP,
  ResendUserPhoneOTP,
  UpdateUserProfile,
  UpdateUserProfileImage,
  ChangePassword,
  DeleteUser,
}
