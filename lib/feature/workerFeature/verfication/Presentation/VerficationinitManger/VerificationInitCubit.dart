import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/VerificationrequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/verficationmodel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationInitCubit extends Cubit<VerificationInitState> {
  final VerficationInitRepo repo;

  VerificationInitCubit(this.repo) : super(VerificationInitInitial()) {
    loadInitialData();
  }
  Future<void> loadInitialData() async {
    emit(VerificationInitLoading());

    final results = await Future.wait([
      repo.getAreas(),
      repo.getDepartmentname(),
    ]);

    final areasResult = results[0];
    final departmentsResult = results[1];
    areasResult.fold(
      (failure) => emit(VerificationInitError(failure.errors.first)),
      (areas) {
        areasList = areas;
        departmentsResult.fold(
          (failure) => emit(VerificationInitError(failure.errors.first)),
          (departments) {
            departmentsList = departments;
            emit(
              VerificationInitSuccess(
                areas: areasList!,
                departments: departmentsList!,
              ),
            );
          },
        );
      },
    );
  }

  VerficationInitList? areasList;
  VerficationInitList? departmentsList;
  Future<void> sendVerificationRequest({
    required VerificationrequestModel request,
  }) async {
    emit(
      VerificationRequestLoading(
        areas: areasList,
        departments: departmentsList,
      ),
    );

    final result = await repo.verificationrequest(request: request);

    result.fold(
      (failure) {
        emit(
          VerificationRequestError(
            failure.errors.first,
            areas: areasList,
            departments: departmentsList,
          ),
        );
      },
      (response) {
        emit(VerificationRequestSuccess());
      },
    );
  }

  Future<void> getVerificationRequestData() async {
    emit(VerificationInitLoading());

    final result = await repo.getvrificationRequest();

    result.fold(
      (failure) {
        emit(VerificationInitError(failure.errors.first));
      },
      (workerRequestModel) {
        emit(VerificationSuccess(workerRequest: workerRequestModel));
      },
    );
  }
}
