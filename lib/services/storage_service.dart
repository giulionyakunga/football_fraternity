import 'dart:convert';
import 'package:football_fraternity/models/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _userProfileKey = 'user_profile';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs.setString(_userProfileKey, jsonEncode(profile.toJson()));
    await _prefs.setBool('first_launch', false);
  }

  UserProfile? getUserProfile() {
    final String? profileJson = _prefs.getString(_userProfileKey);
    if (profileJson == null) return null;
    return UserProfile.fromJson(jsonDecode(profileJson));
  }

  // Add this function to clear the user profile on logout
  Future<void> clearUserProfile() async {
    await _prefs.remove("first_launch");
    await _prefs.remove(_userProfileKey);
  }
}