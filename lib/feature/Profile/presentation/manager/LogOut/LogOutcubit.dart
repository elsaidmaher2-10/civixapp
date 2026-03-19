import 'package:citifix/core/database/remote/error/failureResponse.dart';
import 'package:citifix/feature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/feature/Profile/presentation/manager/LogOut/LogOutState.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogCubit extends Cubit<LogState> {
  final LogOutRepository logRepository;
  LogCubit(this.logRepository) : super(LogInitial());

  Future<void> logout() async {
    emit(LogLoading());
    final Either<FailureResponse, String> result = await logRepository
        .getLogs();
    result.fold(
      (failure) => emit(LogFailure(failure.errors.join())),
      (logs) => emit(LogSuccess(logs)),
    );
  }
}
