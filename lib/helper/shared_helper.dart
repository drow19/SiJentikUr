import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper{
  static String sharedUserId = 'USERID';
  static String sharedUserName = 'USERNAME';
  static String sharedEmail = 'EMAIL';
  static String sharedLogin = 'ISLOGIN';

  static Future<void> setUserLogin(bool isLogin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedLogin, isLogin);
  }

  static Future<void> setUserId(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(sharedUserId, userId);
  }

  static Future<void> setUserName(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedUserName, username);
  }

  static Future<void> setUserEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedEmail, email);
  }

  static Future<bool> getUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getBool(sharedLogin);
  }

  static Future<int> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getInt(sharedUserId);
  }

  static Future<String> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedUserName);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedEmail);
  }
}