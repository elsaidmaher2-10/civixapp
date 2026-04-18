import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/citzencardItem.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCitizenCard(BuildContext context) async {
  String? userinfoStr = PrefrenceManager().getstring("user_profile_data");
  UserProfile? userProfile;

  if (userinfoStr != null) {
    userProfile = UserProfile.fromJson(jsonDecode(userinfoStr));
  }

  await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: context.palette.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
      ),
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
                color: context.palette.kPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w16,
                  vertical: ScreenUtilsManager.h10,
                ),
                child: Row(
                  children: [
                    Text(
                      S.of(context).citizenIdentity,
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s18,
                        fontWeight: FontWeight.bold,
                        color: context.palette.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.cancel_rounded,
                        color: context.palette.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ScreenUtilsManager.h24),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            ScreenUtilsManager.r8,
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height: ScreenUtilsManager.h100,
                            width: ScreenUtilsManager.w100,
                            imageUrl:
                                userProfile?.profileImage ??
                                Constantmanger.defualtImage,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.person, size: 50),
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildItem(
                                S.of(context).fullName,
                                userProfile?.fullName ?? "---",
                              ),
                              SizedBox(height: ScreenUtilsManager.h12),
                              buildItem(
                                S.of(context).nationalID,
                                userProfile?.nationalId ?? "---",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtilsManager.h16),
                    const Divider(),
                    SizedBox(height: ScreenUtilsManager.h16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildItem(
                                S.of(context).address,
                                userProfile?.address ?? "---",
                              ),
                              SizedBox(height: ScreenUtilsManager.h12),
                              buildItem(
                                S.of(context).phone,
                                userProfile?.phoneNumber ?? "---",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w12),
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
