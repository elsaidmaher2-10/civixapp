import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';

abstract class WorkerTasksState {
  const WorkerTasksState();
}

class WorkerTasksInitial extends WorkerTasksState {}

class WorkerTasksLoading extends WorkerTasksState {}

class WorkerTasksSuccess extends WorkerTasksState {
  final ReportResponse response;
  const WorkerTasksSuccess(this.response);

}

class WorkerTasksError extends WorkerTasksState {
  final String message;
  const WorkerTasksError(this.message);

}