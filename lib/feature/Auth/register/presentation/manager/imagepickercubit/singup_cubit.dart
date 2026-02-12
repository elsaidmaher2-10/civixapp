import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit() : super(SingupimageInitial());
  File? image;
  void imagepickerstate(File? file) {
    if (file == null) {
      image = null;
      emit(Singupimagedosentselected());
    } else {
      emit(Singupimageselected(file));
      image = file;
    }
  }

  bool get hasImage => image != null;
}
