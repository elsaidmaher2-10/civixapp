

import 'package:citifix/feature/workerFeature/home/data/repo/homrepo.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/dashbroadHomemanager/cubit/dashbroad_home_manager_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final Homreposatory _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> getWorkerDashboard() async {
    emit(HomeLoading());
    final result = await _repository.workerdashboard();
    result.fold((failure) {
      String message = failure.errors.isNotEmpty
          ? failure.errors.join()
          : "Something went wrong";
      emit(HomeError(message));
    }, ( data) => emit(HomeSuccess(data)));
  }
}
