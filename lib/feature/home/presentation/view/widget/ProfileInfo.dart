import 'dart:ffi';
import 'dart:io';

import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/manager/cubit/user_profile_info_cubit.dart';
import 'package:citifix/feature/home/presentation/view/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfo extends StatelessWidget {
  void Function()? onTap;
  ProfileInfo({required this.onTap});

  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileInfoCubit, UserProfileInfoState>(
      builder: (context, state) {
        if (state is UserProfileInfoLoading) {
          return SpinKitPouringHourGlassRefined(
            color: ColorManger.kprimaryLight,
            size: 70.0,
          );
        }
        if (state is UserProfileInfoSuccess) {
          var user = state.user;
          return Column(
            children: [
              SizedBox(height: ScreenUtilsManager.h32),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  StreamBuilder<File?>(
                    stream: iamgePicker.stream,
                    builder:
                        (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) => CircleAvatar(
                          radius: 68.r,
                          backgroundColor: ColorManger.Lightblue.withOpacity(
                            0.5,
                          ),
                          child: CircleAvatar(
                            radius: 64.r,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: Colors.white,
                              backgroundImage: snapshot.data != null
                                  ? FileImage(snapshot.data)
                                  : AssetImage(AssetValueManager.defualtimage),
                            ),
                          ),
                        ),
                  ),

                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: InkWell(
                      onTap: onTap,
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: ColorManger.white,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: ColorManger.Lightblue,
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilsManager.h18),
              Text(
                user.fullName.toString().toUpperCase(),
                style: GoogleFonts.inter(
                  letterSpacing: 1.1,
                  fontSize: ScreenUtilsManager.s24,
                  fontWeight: FontWeight.w700,
                  color: ColorManger.kprimarydark,
                ),
              ),
              Text(
                user.email.toString(),
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

        return SizedBox.shrink();
      },
    );
  }
}
