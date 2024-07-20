import 'package:shared_preferences/shared_preferences.dart';

class SharedprefrenceHelper{
  static String loginKey="loginkey";
  static String userEmailKey="useremailkey";
  static String userNameKey="usernamekey";
  static String userImageKey="userimagekey";
  static String adminLoginKey="adminloginkey";

  SetLoginkey(bool value) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool(loginKey, value);
  }
  SetUserEmail(String email) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString(userEmailKey, email);
  }
  SetUserName(String name) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString(userNameKey, name);
  }
  SetUserImage(String image) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString(userImageKey,image);
  }

  SetAdminLoginkey(bool value) async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool(adminLoginKey, value);
  }

  Future<bool?> GetLoginkey() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getBool(loginKey);
  }

 Future<String?> GetUserName() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getString(userNameKey);
  }
  Future<String?> GetUserEmail() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getString(userEmailKey);
  }
  Future<String?> GetUserImage() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getString(userImageKey);
  }

  Future<bool?> GetAdminLoginkey() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.getBool(adminLoginKey);
  }

}