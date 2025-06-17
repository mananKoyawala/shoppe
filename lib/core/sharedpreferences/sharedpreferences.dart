import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences pref;

  static const introKey = "intro";
  static const userLogin = "user_login";

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
}
