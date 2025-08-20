import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends StateNotifier<ThemeMode> {
  static const _prefsKey = 'theme_mode';

  ThemeModeController() : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_prefsKey);
    if (value != null) {
      switch (value) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        default:
          state = ThemeMode.system;
      }
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    switch (state) {
      case ThemeMode.light:
        await prefs.setString(_prefsKey, 'light');
        break;
      case ThemeMode.dark:
        await prefs.setString(_prefsKey, 'dark');
        break;
      default:
        await prefs.setString(_prefsKey, 'system');
    }
  }

  void toggle(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    _save();
  }

  void set(ThemeMode mode) {
    state = mode;
    _save();
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>((ref) => ThemeModeController());
