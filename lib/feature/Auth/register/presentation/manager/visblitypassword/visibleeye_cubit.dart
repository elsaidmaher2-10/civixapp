import 'package:flutter_bloc/flutter_bloc.dart';

class VisibleeyeCubit extends Cubit<bool> {
  VisibleeyeCubit() : super(true);
  chanagevisbilitypassword() {
    emit(!state);
  }
}
