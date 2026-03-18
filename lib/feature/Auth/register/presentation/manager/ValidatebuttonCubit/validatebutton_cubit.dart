import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatebuttonCubit extends Cubit<bool> {
  ValidatebuttonCubit() : super(true);

  Future<void> buttonreq() async {
    if (!isClosed) emit(!state);
    await Future.delayed(Duration(seconds: 2));
    if (!isClosed) emit(!state);
  }
}
