import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatebuttonCubit extends Cubit<bool> {
  ValidatebuttonCubit() : super(true);

  Future<void> buttonreq() async {
    // أول emit
    if (!isClosed) emit(!state);

    // تأخير 2 ثانية
    await Future.delayed(Duration(seconds: 2));

    // قبل الـemit الثاني نتأكد إن الـCubit لسه شغال
    if (!isClosed) emit(!state);
  }
}
