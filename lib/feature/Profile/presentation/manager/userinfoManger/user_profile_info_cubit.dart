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
  static const String _cacheKey = "user_profile_data";
  void _loadInitialData() async {
    String? cachedUser = PrefrenceManager().getstring(_cacheKey);
    if (cachedUser != null) {
      emit(
        UserProfileInfoSuccess(UserProfile.fromJson(jsonDecode(cachedUser))),
      );
    } else {
      await getUserProfleInfo();
    }
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
      emit(UserProfileImageUpdatedSuccess(r));
    });
  }

  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    if (isClosed) return;
    emit(EditUserProfileInfoLoading());
    final result = await userprofilerepos.updateProfile(updatedProfile);
    if (isClosed) return;
    result.fold(
      (failure) => emit(EditUserProfileInfoError(failure.errors.join())),
      (response) {
        UserProfile finalProfile;
        String? cachedUser = PrefrenceManager().getstring(_cacheKey);

        if (cachedUser != null) {
          UserProfile oldProfile = UserProfile.fromJson(jsonDecode(cachedUser));
          finalProfile = UserProfile(
            id: response.id ?? oldProfile.id,
            username: response.username ?? oldProfile.username,
            email: response.email ?? oldProfile.email,
            role: response.role ?? oldProfile.role,
            fullName: response.fullName ?? oldProfile.fullName,
            nationalId: response.nationalId ?? oldProfile.nationalId,
            dateOfBirth: response.dateOfBirth ?? oldProfile.dateOfBirth,
            age: response.age ?? oldProfile.age,
            phoneNumber: response.phoneNumber ?? oldProfile.phoneNumber,
            address: response.address ?? oldProfile.address,
            verified: response.verified ?? oldProfile.verified,
            userId: response.userId ?? oldProfile.userId,
            profileImage: response.profileImage ?? oldProfile.profileImage,
          );
        } else {
          finalProfile = response;
        }

        PrefrenceManager().setstring(
          _cacheKey,
          jsonEncode(finalProfile.toJson()),
        );

        emit(EditUserProfileInfoSuccess(finalProfile));
      },
    );
  }
}
