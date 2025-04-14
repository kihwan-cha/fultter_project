// lib/utils/menu_storage.dart
import 'package:shared_preferences/shared_preferences.dart';

class TodayMenuStorage {
  static const String _key = 'menuList';

  // 저장
  static Future<void> saveMenuList(List<String> menuList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, menuList);
  }

  // 불러오기
  static Future<List<String>> loadMenuList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
