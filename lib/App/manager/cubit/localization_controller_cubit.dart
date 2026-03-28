import 'package:bloc/bloc.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'localization_controller_state.dart';
class LocalizationControllerCubit extends Cubit<LocalizationControllerState> {
  LocalizationControllerCubit() : super(LocalizationControllerInitial());
  static const String _langKey = "Lang";
  void fetchLanguage() {
    String? savedLang = PrefrenceManager().getstring(_langKey);
    String initialLang = savedLang ?? "en";
    emit(LocalizationControllerChanged(lang: initialLang));
  }
  void changeLanguage(String lang) {
    PrefrenceManager().setstring(_langKey, lang);
    emit(LocalizationControllerChanged(lang: lang));
  }
}