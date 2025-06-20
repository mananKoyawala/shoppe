import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences pref;

  static const introKey = "intro";
  static const userLogin = "user_login";
  static const accessToken = "access_token";
  static const tempToken = "temp_access_token";

  // * user profile data
  static const userId = "id";
  static const userFirstName = "first_name";
  static const userLastName = "last_name";
  static const userFullName = "full_name";
  static const userImageUrl = "image_url";
  static const userGender = "gender";
  static const userCountry = "country";
  static const userState = "state";
  static const userCity = "city";
  static const userAddress = "address";
  static const userEmail = "email";
  static const userPhoneNumber = "phone_number";
  static const userDob = "dob";
  static const userPinCode = "pin_code";
  static const userIsMobileVerified = "is_mobile_verified";
  static const userIsEmailVerified = "is_email_verified";

  static Future<void> preference() async {
    pref = await SharedPreferences.getInstance();
  }

  static setIntro(bool value) async {
    await pref.setBool(introKey, value);
  }

  static Future<bool> getIntro() async {
    return pref.getBool(introKey) ?? false;
  }

  static setUserLogin(bool value) async {
    await pref.setBool(userLogin, value);
  }

  static Future<bool> getUserLogin() async {
    return pref.getBool(userLogin) ?? false;
  }

  static setAccessToken(String value) async {
    await pref.setString(accessToken, value);
  }

  static Future<String> getAccessToken() async {
    return pref.getString(accessToken) ?? "";
  }

  // * use while verification
  static setTempAccessToken(String value) async {
    await pref.setString(tempToken, value);
  }

  static Future<String> getTempAccessToken() async {
    return pref.getString(tempToken) ?? "";
  }

  // * set profile data
  static setUserId(String value) async {
    await pref.setString(userId, value);
  }

  static Future<String> getUserId() async {
    return pref.getString(userId) ?? "";
  }

  static Future<void> setUserFirstName(String value) async =>
      await pref.setString(userFirstName, value);
  static String getUserFirstName() => pref.getString(userFirstName) ?? "";

  static Future<void> setUserLastName(String value) async =>
      await pref.setString(userLastName, value);
  static String getUserLastName() => pref.getString(userLastName) ?? "";

  static Future<void> setUserFullName(String value) async =>
      await pref.setString(userFullName, value);
  static String getUserFullName() => pref.getString(userFullName) ?? "";

  static Future<void> setUserImageUrl(String value) async =>
      await pref.setString(userImageUrl, value);
  static String getUserImageUrl() => pref.getString(userImageUrl) ?? "";

  static Future<void> setUserGender(String value) async =>
      await pref.setString(userGender, value);
  static String getUserGender() => pref.getString(userGender) ?? "";

  static Future<void> setUserCountry(String value) async =>
      await pref.setString(userCountry, value);
  static String getUserCountry() => pref.getString(userCountry) ?? "";

  static Future<void> setUserState(String value) async =>
      await pref.setString(userState, value);
  static String getUserState() => pref.getString(userState) ?? "";

  static Future<void> setUserCity(String value) async =>
      await pref.setString(userCity, value);
  static String getUserCity() => pref.getString(userCity) ?? "";

  static Future<void> setUserAddress(String value) async =>
      await pref.setString(userAddress, value);
  static String getUserAddress() => pref.getString(userAddress) ?? "";

  static Future<void> setUserEmail(String value) async =>
      await pref.setString(userEmail, value);
  static String getUserEmail() => pref.getString(userEmail) ?? "";

  static Future<void> setUserPhoneNumber(String value) async =>
      await pref.setString(userPhoneNumber, value);
  static String getUserPhoneNumber() => pref.getString(userPhoneNumber) ?? "";

  static Future<void> setUserDob(String value) async =>
      await pref.setString(userDob, value);
  static String getUserDob() => pref.getString(userDob) ?? "";

  static Future<void> setUserPinCode(String value) async =>
      await pref.setString(userPinCode, value);
  static String getUserPinCode() => pref.getString(userPinCode) ?? "";

  static Future<void> setIsMobileVerified(bool value) async =>
      await pref.setBool(userIsMobileVerified, value);
  static bool getIsMobileVerified() =>
      pref.getBool(userIsMobileVerified) ?? false;

  static Future<void> setIsEmailVerified(bool value) async =>
      await pref.setBool(userIsEmailVerified, value);
  static bool getIsEmailVerified() =>
      pref.getBool(userIsEmailVerified) ?? false;

  static clearAllPreferences() {
    pref.clear();
    setIntro(true);
  }
}
