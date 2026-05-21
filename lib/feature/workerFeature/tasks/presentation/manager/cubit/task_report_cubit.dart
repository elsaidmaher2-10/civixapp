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
        emit(WorkerTasksError(failure.errors.join(",")));
      },
      (reportResponse) {
        emit(WorkerTasksSuccess(reportResponse));
      },
    );
  }

  Future<void> searchTasks(String query) async {
    if (query.trim().isEmpty) {
      await getWorkerTasks();
      return;
    }
    emit(WorkerTasksLoading());
    final data = await _workerTaskRepo.getFilterdreports(query: query);
    data.fold(
      (ifLeft) {
        if (isClosed) return;
        emit(ReportNotFound(ifLeft.errors.join()));
      },
      (ifRight) {
        if (isClosed) return;
        emit(WorkerTasksSuccess(ifRight));
      },
    );
  }

  Future<void> changeWorkerTaskStatus({
    required String status,
    required int reportId,
  }) async {
    emit(WorkerChangeTasksLoading());
    final result = await _workerTaskRepo.workertaskChangeStatus(
      status,
      reportId,
    );
    result.fold(
      (failure) {
        emit(WorkerChangeTasksError(failure.errors.join(",")));
      },
      (reportResponse) {
        emit(WorkerChangeTasksSuccess(true));
      },
    );
  }
}
