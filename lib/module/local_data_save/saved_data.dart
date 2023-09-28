import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaved {
  static SharedPreferences? preference;

  static Future<void> init() async {
    preference = await SharedPreferences.getInstance();
  }

  ///id
  static Future<void> saveUserId(String id) async {
    await preference!.setString('userID', id);
  }

  static String getUserID() {
    return preference!.getString('userID') ?? '';
  }

  ///username
  static Future<void> saveUserName(String name) async {
    await preference!.setString('Name', name);
  }

  static String getUserName() {
    return preference!.getString('Name') ?? '';
  }

  ///user email
  static Future<void> saveUserEmail(String email) async {
    await preference!.setString('Email', email);
  }

  static String getUserEmail() {
    return preference!.getString('Email') ?? '';
  }
}
