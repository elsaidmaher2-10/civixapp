import 'package:bloc/bloc.dart';
import 'package:citifix/feature/home/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/home/data/Repos/UserProfileRepos/userprofileRepos.dart';
import 'package:meta/meta.dart';

part 'user_profile_info_state.dart';

class UserProfileInfoCubit extends Cubit<UserProfileInfoState> {
  UserProfileInfoCubit(this.userprofilerepos)
    : super(UserProfileInfoInitial()) {
    getUserProfleInfo();
  }

  final Userprofilerepos userprofilerepos;

  getUserProfleInfo() async {
    emit(UserProfileInfoLoading());
    await Future.delayed(Duration(seconds: 2));
    userprofilerepos.getuserInfo().then((onValue) {
      onValue.fold(
        (l) => emit(UserProfileInfoError(l.errors.join())),
        (r) => emit(UserProfileInfoSuccess(r)),
      );
    });
  }
}
