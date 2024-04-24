import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemes {
  late final ThemeData darkThemeData;
  late final ThemeData lightThemeData;

  late ThemeMode currentThemeMode;

  Future<void> init() async {
    // Load themes from assets
    lightThemeData = ThemeDecoder.decodeThemeData(
        jsonDecode(await rootBundle.loadString('assets/themes/light.json')))!;
    darkThemeData = ThemeDecoder.decodeThemeData(
        jsonDecode(await rootBundle.loadString('assets/themes/dark.json')))!;

    // Get stored theme mode or default to system
    final int? storedThemeModeIndex =
        Get.find<SharedPreferences>().getInt("themeMode");
    currentThemeMode = storedThemeModeIndex != null
        ? ThemeMode.values[storedThemeModeIndex]
        : ThemeMode.system;
  }

  Future<void> changeThemeMode() async {
    // Theme mode loop: System -> Light -> Dark -> System
    currentThemeMode = ThemeMode
        .values[(currentThemeMode.index + 1) % ThemeMode.values.length];
    // Store theme mode
    await Get.find<SharedPreferences>()
        .setInt("themeMode", currentThemeMode.index);
    // Update main theme mode
    Get.changeThemeMode(currentThemeMode);
  }
}
