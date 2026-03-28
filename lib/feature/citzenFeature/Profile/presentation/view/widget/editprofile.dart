// ignore_for_file: use_build_context_synchronously

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/controller/userProfileController.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/EditFromProfile.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/chanagePassword.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/customImagePicker.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/saveeditProfile.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _WorkerEditProfileScreenState();
}

class _WorkerEditProfileScreenState extends State<EditProfileScreen> {
  final Userprofilecontroller userprofilecontroller = Userprofilecontroller();

  @override
  void initState() {
    userprofilecontroller.init();
    super.initState();
  }

  @override
  void dispose() {
    userprofilecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileInfoCubit, UserProfileInfoState>(
      listener: (context, state) {
        if (state is EditUserProfileInfoError) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.message,
          );
        }
        if (state is EditUserProfileInfoSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.green,
            message: S.of(context).profileUpdatedSuccess,
          );
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) Navigator.of(context).pop();
          });
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          progressIndicator: customloading(),
          inAsyncCall: state is EditUserProfileInfoLoading,
          child: Scaffold(
            backgroundColor: ColorManger.reportsPageBackground,
            body: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(context),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtilsManager.h32,
                            ),
                            child: Customimagepicker(
                              userProfile: userprofilecontroller.userProfile,
                            ),
                          ),
                          Editfromprofile(
                            EmailCotroller:
                                userprofilecontroller.emailController,
                            nameCotroller: userprofilecontroller.nameController,
                            phoneCotroller:
                                userprofilecontroller.phoneController,
                            addressCotroller:
                                userprofilecontroller.addressController,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtilsManager.p10,
                              horizontal: ScreenUtilsManager.p23,
                            ),
                            child: const Chanagepassword(),
                          ),
                          SizedBox(height: ScreenUtilsManager.h24),
                          Saveeditprofile(
                            ontap: () {
                              context
                                  .read<UserProfileInfoCubit>()
                                  .updateUserProfile(
                                    UserProfile(
                                      fullName: userprofilecontroller
                                          .nameController
                                          .text,
                                      nationalId: userprofilecontroller
                                          .userProfile
                                          .nationalId,
                                      address: userprofilecontroller
                                          .addressController
                                          .text,
                                      phoneNumber: userprofilecontroller
                                          .phoneController
                                          .text,
                                      email: userprofilecontroller
                                          .emailController
                                          .text,
                                      username: userprofilecontroller
                                          .userProfile
                                          .username,
                                      dateOfBirth: userprofilecontroller
                                          .userProfile
                                          .dateOfBirth,
                                    ),
                                  );
                            },
                            bntcontroller: userprofilecontroller.bntController,
                          ),
                          SizedBox(height: ScreenUtilsManager.h12),
                          _buildSecurityNote(context),
                          SizedBox(height: ScreenUtilsManager.h16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(ScreenUtilsManager.w8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              CupertinoIcons.back,
              color: ColorManger.primary,
              size: ScreenUtilsManager.s20,
            ),
          ),
          Expanded(
            child: Text(
              S.of(context).editProfile,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: ScreenUtilsManager.s20,
                fontWeight: FontWeight.w700,
                color: ColorManger.primary,
              ),
            ),
          ),
          SizedBox(width: ScreenUtilsManager.w48),
        ],
      ),
    );
  }

  Widget _buildSecurityNote(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
      child: Text(
        S.of(context).dataSecurityNote,
        textAlign: TextAlign.center,
        style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF94A3B8)),
      ),
    );
  }
}
