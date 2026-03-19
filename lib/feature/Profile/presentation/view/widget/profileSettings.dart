import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/Profile/presentation/view/Function/ShowCitezenaCard.dart';
import 'package:citifix/feature/Profile/presentation/view/Function/showLanguagePicker.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/ProfileMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilesettings extends StatelessWidget {
  const Profilesettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Constantmanger.settings,
            style: GoogleFonts.inter(
              letterSpacing: 1.6,
              color: ColorManger.lightGrey6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ProfileMenuItem(
                    iconPath: AssetValueManager.language,
                    title: Constantmanger.language,
                    onTap: () async {
                      showLanguagePicker(context);
                    },
                  ),
                  ProfileMenuItem(
                    onTap: () async {
                      showCitizenCard(context);
                    },
                    iconPath: AssetValueManager.identity,
                    title: Constantmanger.identity,
                  ),

                  // ProfileMenuItem(
                  //   iconPath: AssetValueManager.support,
                  //   title: Constantmanger.support,
                  // ),
                  ProfileMenuItem(
                    iconPath: AssetValueManager.accountinformation,
                    title: Constantmanger.accouninormation,
                    onTap: () async {
                      await Navigator.pushNamed(context, Routes.editProfile);
                      context.read<UserProfileInfoCubit>().getUserProfleInfo();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
