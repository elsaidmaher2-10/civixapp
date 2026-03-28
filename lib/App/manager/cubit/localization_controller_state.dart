part of 'localization_controller_cubit.dart';

@immutable
 sealed class LocalizationControllerState {}

final class LocalizationControllerInitial extends LocalizationControllerState {}

final class LocalizationControllerChanged extends LocalizationControllerState {
   LocalizationControllerChanged({required this.lang});
  final String lang;
}
