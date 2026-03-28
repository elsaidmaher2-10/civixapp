import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerCubit extends Cubit<int> {
  WorkerCubit() : super(0);
  void changeCurrentIndex(int newIndex) {
    if (state != newIndex) {
      emit(newIndex);
    }
  }
}
