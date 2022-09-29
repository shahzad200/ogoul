import 'package:shared_preferences/shared_preferences.dart';



class SharedPrefClient {
  static const _sheUserId = 'user_id';
  static const _sheUserName = 'user_name';
  static const _sheUserEmail = 'user_email';
  static const _sheUserPhone = 'user_phone';
  static const _sheUserToken = 'token';
  static const _sheRole = 'role';
  static const _sheState = 'state';

  Future<void> setRole(String role) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheRole, role);
  }
  Future<String?> getRole() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheRole) ?? 'role';
  }


  Future<void> setState(String state) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheState, state);
  }
  Future<String?> getState() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheState) ?? 'nothing';
  }

  Future<void> setUserId(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserId, user);
  }
  Future<String?> getUserId() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserId) ?? '-21';
  }


  Future<void> setUserName(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserName, user);
  }
  Future<String?> getUserName() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserName);
  }


  Future<void> setUserEmail(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserEmail, user);
  }
  Future<String?> getUserEmail() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserEmail);
  }

  Future<void> setUserPhone(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserPhone, user);
  }
  Future<String?> getUserPhone() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserPhone);
  }

  Future<void> setUserToken(String user) async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString(_sheUserToken, user);
  }
  Future<String?> getUserToken() async {
    final sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString(_sheUserToken);
  }


}