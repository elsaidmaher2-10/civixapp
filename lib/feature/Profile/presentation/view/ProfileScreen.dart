import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/Profile/data/repos/UserProfileRepos/LogOutRepos.dart';
import 'package:citifix/feature/Profile/presentation/manager/LogOut/LogOutState.dart';
import 'package:citifix/feature/Profile/presentation/manager/LogOut/LogOutcubit.dart';
import 'package:citifix/feature/Profile/presentation/manager/controller/imageController.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/ProfileInfo.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/image_picker_menu.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/profileSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // دالة تسجيل الخروج مع التأكد من وجود الـ Context الصحيح
  Future<void> _onLogoutPressed(BuildContext context) async {
    final confirmed = await LogoutConfirmDialog.show(context);
    if (confirmed == true && context.mounted) {
      context.read<LogCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LogCubit(getIt<LogOutRepository>())),
      ],
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: ColorManger.reportsPageBackground,
              appBar: AppBar(
                backgroundColor: ColorManger.reportsPageBackground,
                elevation: 0,
                title: Text(
                  Constantmanger.proile,
                  style: GoogleFonts.inter(
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
                        PrefrenceManager().remove(Constantmanger.accessToken);
                        PrefrenceManager().remove(Constantmanger.refreshToken);
                        PrefrenceManager().remove(Constantmanger.userid);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.login,
                          (route) => false,
                        );
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
                          SizedBox(height: ScreenUtilsManager.h16),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtilsManager.w32,
                            ),
                            child: logoutState is LogLoading
                                ? Center(
                                    child: CupertinoActivityIndicator(
                                      color: ColorManger.kPrimary,
                                    ),
                                  )
                                : CustomButton(
                                    onPressed: () => _onLogoutPressed(context),
                                    icon: const Icon(Icons.logout_rounded),
                                    backgroundColor: ColorManger.redLight,
                                    foregroundColor: ColorManger.red,
                                    lable: Constantmanger.logout,
                                  ),
                          ),
                          SizedBox(height: ScreenUtilsManager.h16),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const LogoutConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(
        ScreenUtilsManager.w24,
        ScreenUtilsManager.h20,
        ScreenUtilsManager.w24,
        ScreenUtilsManager.h12,
      ),
      actionsPadding: EdgeInsets.fromLTRB(
        ScreenUtilsManager.w16,
        0,
        ScreenUtilsManager.w16,
        ScreenUtilsManager.h16,
      ),
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
            'Sign out',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        "Are you sure you want to log out of your account?",
        style: GoogleFonts.inter(fontSize: 14, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorManger.kPrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                ),
                child: Text(
                  'LogOut',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
