import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:citifix/core/resource/constantmanger.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    final result = await userprofilerepos.getuserInfo();
    if (isClosed) return;

    result.fold(
      (l) => emit(UserProfileInfoError(l.errors.join())),
      (r) => emit(UserProfileInfoSuccess(r)),
    );
  }

  updateUserProfleImage(File image) async {
    if (isClosed) return;

    final onValue = await userprofilerepos.updateuserImage(image);
    
    if (isClosed) return;

    onValue.fold(
      (l) => emit(UserProfileInfoError(l.errors.join())),
      (r) => emit(UserProfileInfoImageUpdated(Constantmanger.updateImage)),
    );
  }
}