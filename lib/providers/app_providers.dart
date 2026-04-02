import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeNotifier(prefs);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  ThemeNotifier(this._prefs) : super(_loadThemeMode(_prefs));

  static ThemeMode _loadThemeMode(SharedPreferences prefs) {
    final mode = prefs.getString(_key);
    if (mode == 'dark') return ThemeMode.dark;
    if (mode == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      _prefs.setString(_key, 'light');
    } else {
      state = ThemeMode.dark;
      _prefs.setString(_key, 'dark');
    }
  }

  bool get isDark => state == ThemeMode.dark;
}

final bookmarkProvider = StateNotifierProvider<BookmarkNotifier, List<String>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return BookmarkNotifier(prefs);
});

class BookmarkNotifier extends StateNotifier<List<String>> {
  final SharedPreferences _prefs;
  static const _key = 'bookmarks';

  BookmarkNotifier(this._prefs) : super(_prefs.getStringList(_key) ?? []);

  void toggleBookmark(String id) {
    if (state.contains(id)) {
      state = state.where((item) => item != id).toList();
    } else {
      state = [...state, id];
    }
    _prefs.setStringList(_key, state);
  }

  bool isBookmarked(String id) => state.contains(id);
}
