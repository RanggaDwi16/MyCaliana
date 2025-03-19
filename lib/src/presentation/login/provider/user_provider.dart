import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_caliana/src/core/provider/shared_pref_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_caliana/src/core/model/user_model.dart';



/// **Provider untuk menyimpan UserModel**
final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  return UserNotifier(prefs);
});

class UserNotifier extends StateNotifier<UserModel?> {
  final SharedPreferences? _prefs;

  UserNotifier(this._prefs) : super(null) {
    _loadUser();
  }

  /// **Simpan user ke SharedPreferences**
  Future<void> saveUser(UserModel user) async {
    if (_prefs != null) {
      final userJson = jsonEncode(user.toJson());
      await _prefs.setString('user', userJson);
      state = user;
    }
  }

  /// **Ambil user dari SharedPreferences saat aplikasi dibuka**
  void _loadUser() {
    if (_prefs != null) {
      final userJson = _prefs.getString('user');
      if (userJson != null) {
        state = UserModel.fromJson(jsonDecode(userJson));
      }
    }
  }

  /// **Hapus user dari SharedPreferences (Logout)**
  Future<void> logout() async {
    if (_prefs != null) {
      await _prefs.remove('user');
      state = null;
    }
  }
}
