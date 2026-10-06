import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/constants.dart';


class LocalStorage {
  static final box = GetStorage();

  static void writeString(String key, String v) {
    box.write(key, v);
  }

  static String getString(String key) {
    return box.read(key) ?? "";
  }

  static void writeBool(String key, bool v) {
    box.write(key, v);
  }

  static bool getBool(String key) {
    return box.read(key) ?? false;
  }

  static String get savedTheme {
    return box.read(GetXStorageConstants.themeMode) ?? 'system';
  }

  static ThemeMode getTheme() {
    switch (savedTheme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static void saveTheme(ThemeMode mode) {
    String value;

    switch (mode) {
      case ThemeMode.dark:
        value = 'dark';
        break;
      case ThemeMode.light:
        value = 'light';
        break;
      case ThemeMode.system:
        value = 'system';
        break;
    }

    box.write(GetXStorageConstants.themeMode, value);
  }

  static void changeTheme() {
    final currentMode = getTheme();

    if (currentMode == ThemeMode.light) {
      saveTheme(ThemeMode.dark);
      Get.changeThemeMode(ThemeMode.dark);
    } else if (currentMode == ThemeMode.dark) {
      saveTheme(ThemeMode.system);
      Get.changeThemeMode(ThemeMode.system);
    } else {
      saveTheme(ThemeMode.light);
      Get.changeThemeMode(ThemeMode.light);
    }
  }

  static void clearValueByKey(String key) {
    box.remove(key);
  }

  static void setAuthToken(String token) {
    box.write(GetXStorageConstants.authToken, token);
  }

  static String getAuthToken() {
    return box.read(GetXStorageConstants.authToken) ?? "";
  }

  static void clear() {
    box.erase();
  }
}