import 'package:bloc/bloc.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';

/// Persists and exposes [ThemeMode] for [MaterialApp.themeMode].
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void fetchTheme() {
    final String? raw =
        PrefrenceManager().getstring(Constantmanger.themeModePrefKey);
    emit(_decode(raw));
  }

  void setThemeMode(ThemeMode mode) {
    PrefrenceManager().setstring(
      Constantmanger.themeModePrefKey,
      _encode(mode),
    );
    emit(mode);
  }

  static String _encode(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
  }

  static ThemeMode _decode(String? raw) {
    return switch (raw) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
