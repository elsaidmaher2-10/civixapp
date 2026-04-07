 class LogState {}
class LogInitial extends LogState {}
class LogLoading extends LogState {}
class LogSuccess extends LogState {
  final String logs;
  LogSuccess(this.logs);
}
class LogFailure extends LogState {
  final String failure;
  LogFailure(this.failure);
}