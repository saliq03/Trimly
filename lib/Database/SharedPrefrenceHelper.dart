import 'package:shared_preferences/shared_preferences.dart';

class SharedprefrenceHelper{
  static String loginKey="loginkey";

  SetLoginkey(bool value) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool(loginKey, value);
  }


  Future<bool?> GetLoginkey() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getBool(loginKey);
  }
}