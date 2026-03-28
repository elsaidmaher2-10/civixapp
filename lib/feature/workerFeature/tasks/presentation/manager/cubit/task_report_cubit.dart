import 'package:citifix/feature/workerFeature/tasks/data/repos/worker_task_Repo.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkerTasksCubit extends Cubit<WorkerTasksState> {
  final WorkerTaskRepo _workerTaskRepo;

  WorkerTasksCubit(this._workerTaskRepo) : super(WorkerTasksInitial());

  Future<void> getWorkerTasks() async {
    emit(WorkerTasksLoading());
    final result = await _workerTaskRepo.workertasRepo();
    result.fold(
      (failure) {
        emit(WorkerTasksError(failure.errors.join(", ")));
      },
      (reportResponse) {
        emit(WorkerTasksSuccess(reportResponse));
      },
    );
  }
}
