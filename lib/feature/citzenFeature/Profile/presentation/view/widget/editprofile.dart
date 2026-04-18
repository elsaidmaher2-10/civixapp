import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/core/cubit/controller/userProfileController.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
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
  late final Userprofilecontroller userprofilecontroller;

  @override
  void initState() {
    super.initState();
    userprofilecontroller = Userprofilecontroller();
    userprofilecontroller.init();
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
            backgroundColor: context.palette.red,
            message: state.message,
          );
        }
        if (state is EditUserProfileInfoSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: context.palette.green,
            message: S.of(context).profileUpdatedSuccess,
          );
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) Navigator.of(context).pop();
          });
        }
      },
      builder: (context, state) {
        final role =
            userprofilecontroller.userProfile?.role?.toLowerCase() ?? "";
        final isWorker = role == "worker";

        if (userprofilecontroller.userProfile == null) {
          return _buildLoadingState(context, isWorker);
        }

        return ModalProgressHUD(
          progressIndicator: isWorker
              ? CupertinoActivityIndicator(
                  color: context.palette.workerprimary,
                  radius: ScreenUtilsManager.r12,
                )
              : customloading(),
          inAsyncCall: state is EditUserProfileInfoLoading,
          child: Scaffold(
            backgroundColor: context.palette.reportsPageBackground,
            body: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(context, role),
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
                              role: isWorker,
                              userProfile: userprofilecontroller.userProfile,
                            ),
                          ),
                          Editfromprofile(
                            role: isWorker,
                            EmailCotroller:
                                userprofilecontroller.emailController,
                            nameCotroller: userprofilecontroller.nameController,
                            phoneCotroller:
                                userprofilecontroller.phoneController,
                            addressCotroller:
                                userprofilecontroller.addressController,
                          ),
                          if (!isWorker)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: ScreenUtilsManager.p10,
                                horizontal: ScreenUtilsManager.p23,
                              ),
                              child: const Chanagepassword(),
                            ),
                          SizedBox(height: ScreenUtilsManager.h24),
                          Saveeditprofile(
                            role: isWorker,
                            ontap: () => _handleSave(context),
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

  void _handleSave(BuildContext context) {
    if (userprofilecontroller.userProfile != null) {
      context.read<UserProfileInfoCubit>().updateUserProfile(
        UserProfile(
          fullName: userprofilecontroller.nameController.text,
          nationalId: userprofilecontroller.userProfile!.nationalId,
          address: userprofilecontroller.addressController.text,
          phoneNumber: userprofilecontroller.phoneController.text,
          email: userprofilecontroller.emailController.text,
          username: userprofilecontroller.userProfile!.username,
          dateOfBirth: userprofilecontroller.userProfile!.dateOfBirth,
        ),
      );
    }
  }

  Widget _buildLoadingState(BuildContext context, bool isWorker) {
    return Scaffold(
      backgroundColor: context.palette.reportsPageBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isWorker
                ? CupertinoActivityIndicator(
                    color: context.palette.workerprimary,
                    radius: ScreenUtilsManager.r12,
                  )
                : customloading(),
            SizedBox(height: ScreenUtilsManager.h16),
            Text(
              S.of(context).loading,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: context.palette.lightGrey2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String role) {
    final iconColor = role == "worker"
        ? context.palette.workerprimary
        : context.palette.primary;

    return Padding(
      padding: EdgeInsetsDirectional.all(ScreenUtilsManager.w8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<UserProfileInfoCubit>().getUserProfleInfo();
            },
            icon: Icon(
              CupertinoIcons.back,
              color: iconColor,
              size: ScreenUtilsManager.s20,
            ),
          ),
          Expanded(
            child: Text(
              S.of(context).editProfile,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s20,
                fontWeight: FontWeight.w700,
                color: iconColor,
              ),
            ),
          ),
          SizedBox(width: ScreenUtilsManager.w48),
        ],
      ),
    );
  }

  // ملاحظة الأمان
  Widget _buildSecurityNote(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
      child: Text(
        S.of(context).dataSecurityNote,
        textAlign: TextAlign.center,
        style: GoogleFonts.cairo(
          fontSize: 12,
          color: const Color(0xFF94A3B8),
          height: 1.4,
        ),
      ),
    );
  }
}
