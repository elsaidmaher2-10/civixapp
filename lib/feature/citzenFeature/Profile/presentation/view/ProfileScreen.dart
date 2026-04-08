import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/core/cubit/LogOut/LogOutState.dart';
import 'package:citifix/core/cubit/LogOut/LogOutcubit.dart';
import 'package:citifix/core/cubit/controller/imageController.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/ProfileInfo.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/image_picker_menu.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/widget/profileSettings.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _onLogoutPressed(BuildContext context) async {
    final confirmed = await LogoutConfirmDialog.show(context);
    if (confirmed == true && context.mounted) {
      context.read<LogCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogCubit(getIt<LogOutRepository>()),
      child: Scaffold(
        backgroundColor: ColorManger.reportsPageBackground,
        appBar: AppBar(
          backgroundColor: ColorManger.reportsPageBackground,
          elevation: 0,
          title: Text(
            S.of(context).profile,
            style: GoogleFonts.cairo(
              color: ColorManger.kPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<UserProfileInfoCubit, UserProfileInfoState>(
              listener: (context, state) {
                if (state is UserProfileImageUpdatedSuccess ||
                    state is UserProfileInfoError) {
                  ImagePickerController().reset();
                }
              },
            ),
            BlocListener<LogCubit, LogState>(
              listener: (context, state) {
                if (state is LogSuccess) {
                  Customsnackbar.show(
                    backgroundColor: Colors.green,
                    context: context,
                    message: state.logs,
                  );
                  PrefrenceManager().remove(Constantmanger.refreshToken);
                  PrefrenceManager().remove(Constantmanger.accessToken);
                  PrefrenceManager().remove(Constantmanger.cacheKey);
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil(Routes.login, (route) => false);
                }
                if (state is LogFailure) {
                  Customsnackbar.show(
                    backgroundColor: Colors.red,
                    context: context,
                    message: state.failure,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<LogCubit, LogState>(
            builder: (context, logoutState) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProfileInfo(
                      onTap: () async {
                        final image = await ImagePickerMenu.show(context);
                        if (image != null && context.mounted) {
                          context
                              .read<UserProfileInfoCubit>()
                              .updateUserProfleImage(image);
                        }
                      },
                    ),
                    const Profilesettings(),
                    SizedBox(height: ScreenUtilsManager.h24),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w32,
                      ),
                      child: logoutState is LogLoading
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                color: ColorManger.kPrimary,
                              ),
                            )
                          : CustomButton(
                              onPressed: () => _onLogoutPressed(context),
                              icon: const Icon(Icons.logout_rounded),
                              backgroundColor: ColorManger.redLight,
                              foregroundColor: ColorManger.red,
                              lable: S.of(context).logout,
                            ),
                    ),
                    SizedBox(height: ScreenUtilsManager.h32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LogoutConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
      ),
      backgroundColor: Colors.white,
      title: Column(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtilsManager.h16),
            decoration: BoxDecoration(
              color: ColorManger.redLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout_rounded,
              color: ColorManger.red,
              size: ScreenUtilsManager.s32,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          Text(
            S.of(context).logout,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      content: Text(
        S.of(context).logoutConfirmationMessage,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s14,
          color: Colors.black54,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ColorManger.kPrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                ),
                child: Text(
                  S.of(context).cancel,
                  style: GoogleFonts.cairo(
                    color: ColorManger.kPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: ScreenUtilsManager.w12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManger.red,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                ),
                child: Text(
                  S.of(context).logout,
                  style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
