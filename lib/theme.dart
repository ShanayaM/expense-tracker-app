import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

Future<ThemeData> initappTheme() async {
  String mode =
      await getSharedPreference(ThemeSharedPreferenceKey.mode.index.toString());
  print(mode);
  if (mode == "dark")
    return appDarkTheme();
  else
    return appTheme();
}

ThemeData appTheme({Color? color}) {
  TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5!.copyWith(color: Colors.black),
        headline6: base.headline6!.copyWith(color: Colors.black),
        headline4: base.headline4!.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
        headline3: base.headline3!.copyWith(color: Colors.black),
        headline2: base.headline2!.copyWith(color: Colors.black),
        headline1: base.headline1!.copyWith(color: Colors.black));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _textTheme(base.textTheme),
      primaryColor: color != null ? color : Colors.blue);
}

ThemeData appDarkTheme({Color? color}) {
  TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5!.copyWith(color: Colors.black),
        headline6: base.headline6!.copyWith(color: Colors.black),
        headline4: base.headline4!.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
        headline3: base.headline3!.copyWith(color: Colors.black),
        headline2: base.headline2!.copyWith(color: Colors.black),
        headline1: base.headline1!.copyWith(color: Colors.black));
  }

  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      textTheme: _textTheme(base.textTheme),
      primaryColor: color != null ? color : Colors.black);
}

void setSharedPreference(String key, String theme) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("theme" + key, theme);
}

Future<String> getSharedPreference(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String str = prefs.getString("theme" + key)!;
  return str;
}

enum ThemeSharedPreferenceKey {
  mode, // dark, light
  tab, // box, normal
  color // app color
}
