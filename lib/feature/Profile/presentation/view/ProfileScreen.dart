import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/Profile/presentation/manager/controller/imageController.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/ProfileInfo.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/image_picker_menu.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/profileSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManger.reportsPageBackground,
        appBar: AppBar(
          backgroundColor: ColorManger.reportsPageBackground,
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
        body: BlocListener<UserProfileInfoCubit, UserProfileInfoState>(
          listener: (context, state) {
            if (state is UserProfileImageUpdatedSuccess ||
                state is UserProfileInfoError) {
              ImagePickerController().reset();
            } else {}
          },
          child: SingleChildScrollView(
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
                Profilesettings(),
                SizedBox(height: ScreenUtilsManager.h16),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w32,
                  ),
                  child: CustomButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout),
                    backgroundColor: ColorManger.redLight,
                    foregroundColor: ColorManger.red,
                    lable: Constantmanger.logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
