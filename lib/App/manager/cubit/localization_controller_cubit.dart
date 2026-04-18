import 'package:bloc/bloc.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'localization_controller_state.dart';

class LocalizationControllerCubit extends Cubit<LocalizationControllerState> {
  LocalizationControllerCubit() : super(LocalizationControllerInitial());

  /// SharedPreferences key for the selected locale (`en` / `ar`).
  static const String languagePrefKey = 'Lang';

  void fetchLanguage() {
    String? savedLang = PrefrenceManager().getstring(languagePrefKey);
    String initialLang = savedLang ?? "en";
    emit(LocalizationControllerChanged(lang: initialLang));
  }

  void changeLanguage(String lang) {
    PrefrenceManager().setstring(languagePrefKey, lang);
    emit(LocalizationControllerChanged(lang: lang));
    PrefrenceManager().remove("categories");
  }
}
