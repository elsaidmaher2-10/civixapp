import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/Profile/presentation/view/Function/ShowCitezenaCard.dart';
import 'package:citifix/feature/Profile/presentation/view/Function/showLanguagePicker.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/ProfileMenu.dart';
import 'package:citifix/generated/l10n.dart';
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
            S.of(context).settings,
            style: GoogleFonts.inter(
              letterSpacing: 1.6,
              color: ColorManger.lightGrey6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Column(
            children: [
              ProfileMenuItem(
                iconPath: AssetValueManager.language,
                title: S.of(context).language,
                onTap: () => showLanguagePicker(context),
              ),
              ProfileMenuItem(
                iconPath: AssetValueManager.identity,
                title: S.of(context).identity,
                onTap: () => showCitizenCard(context),
              ),
              ProfileMenuItem(
                iconPath: AssetValueManager.accountinformation,
                title: S.of(context).accountInformation,
                onTap: () async {
                  await Navigator.pushNamed(context, Routes.editProfile);
                  if (context.mounted) {
                    context.read<UserProfileInfoCubit>().getUserProfleInfo();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
