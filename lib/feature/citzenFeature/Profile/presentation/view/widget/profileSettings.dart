import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/ShowCitezenaCard.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/showLanguagePicker.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/Function/show_theme_picker.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/ProfileMenu.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
            style: GoogleFonts.cairo(
              letterSpacing: 1.6,
              color: context.palette.lightGrey6,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Column(
            children: [
              ProfileMenuItem(
                iconPath: SvgPicture.asset(
                  AssetValueManager.language,
                  colorFilter: ColorFilter.mode(
                    context.palette.lightBlue.withOpacity(0.1),
                    BlendMode.srcATop,
                  ),
                ),

                title: S.of(context).language,
                onTap: () => showLanguagePicker(context, false),
              ),
              // ProfileMenuItem(
              //   iconPath: Container(
              //     padding: EdgeInsets.all(6.w),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       color: context.palette.lightBlue.withOpacity(0.18),
              //     ),
              //     child: Icon(
              //       Icons.dark_mode_outlined,
              //       color: context.palette.lightBlue,
              //     ),
              //   ),
              //   title: Localizations.localeOf(context).languageCode == 'ar'
              //       ? 'المظهر'
              //       : 'Theme',
              //   onTap: () => showThemePicker(context),
              // ),
              ProfileMenuItem(
                iconPath: SvgPicture.asset(
                  AssetValueManager.identity,
                  colorFilter: ColorFilter.mode(
                    context.palette.lightBlue.withOpacity(0.1),
                    BlendMode.srcATop,
                  ),
                ),

                title: S.of(context).identity,
                onTap: () => showCitizenCard(context),
              ),
              ProfileMenuItem(
                iconPath: SvgPicture.asset(
                  AssetValueManager.accountinformation,

                  colorFilter: ColorFilter.mode(
                    context.palette.lightBlue.withOpacity(0.1),
                    BlendMode.srcATop,
                  ),
                ),
                title: S.of(context).accountInformation,
                onTap: () async {
                  await Navigator.pushNamed(context, Routes.editProfile);
                  if (context.mounted) {
                    context.read<UserProfileInfoCubit>().getUserProfleInfo();
                  }
                },
              ),
              ProfileMenuItem(
                iconPath: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: context.palette.lightBlue.withOpacity(0.18),
                  ),
                  child: Icon(
                    Icons.list_outlined,
                    color: context.palette.lightBlue,
                  ),
                ),
                title: S.of(context).help,
                onTap: () {
                  Navigator.pushNamed(context, Routes.helpSupportRoute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
