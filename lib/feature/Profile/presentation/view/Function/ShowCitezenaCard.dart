import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/citzencardItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCitizenCard(context) async {
  String? userinfoStr = PrefrenceManager().getstring("user_profile_data");
  UserProfile? userProfile;
  if (userinfoStr != null) {
    userProfile = UserProfile.fromJson(jsonDecode(userinfoStr));
  }
  await showCupertinoDialog(
    context: context,
    builder: (context) => Dialog(
      insetAnimationCurve: Curves.easeInOut,
      backgroundColor: ColorManger.white,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                color: ColorManger.kPrimary,
                padding: EdgeInsets.all(ScreenUtilsManager.h10),
                child: Row(
                  children: [
                    Text(
                      Constantmanger.citizenIdentity,
                      style: GoogleFonts.inter(
                        fontSize: ScreenUtilsManager.s18,
                        fontWeight: FontWeight.w600,
                        color: ColorManger.white,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: ColorManger.white,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.h24,
                  vertical: ScreenUtilsManager.h24,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          height: ScreenUtilsManager.w90,
                          width: ScreenUtilsManager.h120,
                          imageUrl:
                              userProfile?.profileImage ??
                              Constantmanger.defualtImage,
                        ),
                        SizedBox(width: ScreenUtilsManager.w12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildItem(
                                Constantmanger.fullName,
                                userProfile?.fullName ?? "Ahmed Mahmoud Hassan",
                              ),
                              SizedBox(height: ScreenUtilsManager.h10),
                              buildItem(
                                Constantmanger.nationalID,
                                userProfile?.nationalId ?? "29801011234567",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilsManager.h16),
                    Divider(),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildItem(
                                Constantmanger.address,
                                userProfile?.address ?? "Mansoura",
                              ),
                              SizedBox(height: ScreenUtilsManager.h10),
                              buildItem(
                                "DateBirth",
                                userProfile?.dateOfBirth ?? "12-8-2004",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildItem(Constantmanger.gender, "Male"),
                              SizedBox(height: ScreenUtilsManager.h10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
