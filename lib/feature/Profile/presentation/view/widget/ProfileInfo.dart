import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/Profile/presentation/manager/controller/imageController.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfo extends StatelessWidget {
  final void Function()? onTap;
  const ProfileInfo({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileInfoCubit, UserProfileInfoState>(
      buildWhen: (previous, current) =>
          current is UserProfileInfoSuccess ||
          current is UserProfileInfoLoading ||
          current is UserProfileImageLoading ||
          current is UserProfileImageUpdatedSuccess,

      listener: (context, state) {
        if (state is UserProfileImageUpdatedSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.green,
            message: "The active image has been updated.",
          );
        }
        if (state is UserProfileInfoError) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        UserProfile? user;
        if (state is UserProfileInfoSuccess) {
          user = state.user;
        } else if (state is UserProfileImageUpdatedSuccess) {
          user = state.user;
        } else if (state is UserProfileImageLoading) {
          user = state.user;
        }
        final isImageLoading = state is UserProfileImageLoading;
        if (user == null) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: SpinKitPouringHourGlassRefined(
              color: ColorManger.kprimaryLight,
              size: 70.h,
            ),
          );
        }

        PrefrenceManager().setstring(Constantmanger.userid, user.id);

        return Column(
          children: [
            SizedBox(height: ScreenUtilsManager.h32),
            Stack(
              clipBehavior: Clip.none,
              children: [
                StreamBuilder<File?>(
                  stream: ImagePickerController().stream,
                  builder: (context, pickedFile) {
                    ImageProvider imageProvider;
                    if (pickedFile.data != null) {
                      imageProvider = FileImage(pickedFile.data!);
                    } else if (user!.profileImage != null &&
                        user.profileImage!.isNotEmpty) {
                      imageProvider = user.profileImage!.startsWith('http')
                          ? CachedNetworkImageProvider(user.profileImage!)
                          : FileImage(File(user.profileImage!));
                    } else {
                      imageProvider = AssetImage(
                        AssetValueManager.defualtimage,
                      );
                    }
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 68.r,
                          backgroundColor: ColorManger.Lightblue.withOpacity(
                            0.5,
                          ),
                          child: CircleAvatar(
                            radius: 64.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: ColorManger.Lightgrey,
                              backgroundImage: imageProvider,
                            ),
                          ),
                        ),
                        if (isImageLoading)
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Colors.black38,
                            child: SpinKitPouringHourGlassRefined(
                              color: Colors.white,
                              size: 40.h,
                            ),
                          ),
                      ],
                    );
                  },
                ),

                Positioned(
                  bottom: -4,
                  right: -4,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(25.r),
                    child: CircleAvatar(
                      radius: 25.r,
                      backgroundColor: ColorManger.white,
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: ColorManger.Lightblue,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ScreenUtilsManager.h18),
            Text(
              user.fullName?.toUpperCase() ?? "UNKNOWN USER",
              style: GoogleFonts.inter(
                letterSpacing: 1.1,
                fontSize: ScreenUtilsManager.s24,
                fontWeight: FontWeight.w700,
                color: ColorManger.kprimarydark,
              ),
            ),
            Text(
              user.email ?? "",
              style: GoogleFonts.inter(
                fontSize: ScreenUtilsManager.s14,
                fontWeight: FontWeight.w300,
                color: ColorManger.Lightgrey2,
              ),
            ),

            SizedBox(height: ScreenUtilsManager.h32),
          ],
        );
      },
    );
  }
}
