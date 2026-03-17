import 'dart:convert';
import 'dart:io';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_profile_info_state.dart';

class UserProfileInfoCubit extends Cubit<UserProfileInfoState> {
  UserProfileInfoCubit(this.userprofilerepos)
    : super(UserProfileInfoInitial()) {
    _loadInitialData();
  }

  final Userprofilerepos userprofilerepos;

  void _loadInitialData() async {
    String? cachedUser = PrefrenceManager().getstring("user_profile_data");
    if (cachedUser != null) {
      emit(
        UserProfileInfoSuccess(UserProfile.fromJson(jsonDecode(cachedUser))),
      );
      await _refreshFromNetwork();
    } else {
      await getUserProfleInfo();
    }
  }

  Future<void> _refreshFromNetwork() async {
    final result = await userprofilerepos.getuserInfo();
    result.fold((l) => null, (r) => emit(UserProfileInfoSuccess(r)));
  }

  Future<void> getUserProfleInfo() async {
    if (state is! UserProfileInfoSuccess) {
      emit(UserProfileInfoLoading());
    }
    final result = await userprofilerepos.getuserInfo();
    result.fold(
      (l) => emit(UserProfileInfoError(l.errors.join())),
      (r) => emit(UserProfileInfoSuccess(r)),
    );
  }

  Future<void> updateUserProfleImage(File image) async {
    if (isClosed) return;
    UserProfile? currentUser;
    if (state is UserProfileInfoSuccess) {
      currentUser = (state as UserProfileInfoSuccess).user;
    } else if (state is UserProfileImageUpdatedSuccess) {
      currentUser = (state as UserProfileImageUpdatedSuccess).user;
    }
    if (currentUser == null) return;
    emit(UserProfileImageLoading(currentUser));
    final result = await userprofilerepos.updateuserImage(image);
    if (isClosed) return;
    result.fold((l) => emit(UserProfileInfoError(l.errors.join())), (r) {
      PrefrenceManager().setstring(Constantmanger.userid, r.id);
      emit(UserProfileImageUpdatedSuccess(r));
    });
  }
}
