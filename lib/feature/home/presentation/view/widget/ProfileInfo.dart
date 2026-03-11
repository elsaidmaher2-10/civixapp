import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/feature/home/presentation/manager/cubit/user_profile_info_cubit.dart';
import 'package:citifix/feature/home/presentation/view/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
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
          current is UserProfileInfoLoading,
      listener: (context, state) {
        if (state is UserProfileInfoImageUpdated) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.green,
            message: state.message,
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
        if (state is UserProfileInfoSuccess) {
          final user = state.user;

          return Column(
            children: [
              SizedBox(height: ScreenUtilsManager.h32),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  StreamBuilder<File?>(
                    stream: iamgePicker.stream,
                    builder: (context, snapshot) {
                      ImageProvider imageProvider;
                      if (snapshot.hasData && snapshot.data != null) {
                        imageProvider = FileImage(snapshot.data!);
                      } else if (user.profileImage != null &&
                          user.profileImage!.isNotEmpty) {
                        imageProvider = user.profileImage!.startsWith('http')
                            ? CachedNetworkImageProvider(user.profileImage!)
                            : FileImage(File(user.profileImage!))
                                  as ImageProvider;
                      } else {
                        imageProvider = AssetImage(
                          AssetValueManager.defualtimage,
                        );
                      }

                      return CircleAvatar(
                        radius: 68.r,
                        backgroundColor: ColorManger.Lightblue.withOpacity(0.5),
                        child: CircleAvatar(
                          radius: 64.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor: ColorManger.Lightgrey,
                            backgroundImage: imageProvider,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(bottom: -4, right: -4, child: _buildEditButton()),
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
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: SpinKitPouringHourGlassRefined(
            color: ColorManger.kprimaryLight,
            size: 70.h,
          ),
        );
      },
    );
  }

  Widget _buildEditButton() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.r),
      child: CircleAvatar(
        radius: 25.r,
        backgroundColor: ColorManger.white,
        child: CircleAvatar(
          radius: 20.r,
          backgroundColor: ColorManger.Lightblue,
          child: const Icon(Icons.edit, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
