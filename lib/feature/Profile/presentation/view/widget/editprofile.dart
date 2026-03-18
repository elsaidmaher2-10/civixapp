import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/Profile/presentation/manager/controller/userProfileController.dart';
import 'package:citifix/feature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/EditFromProfile.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/chanagePassword.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/customImagePicker.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/image_picker_menu.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/saveeditProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _WorkerEditProfileScreenState();
}

class _WorkerEditProfileScreenState extends State<EditProfileScreen> {
  Userprofilecontroller userprofilecontroller = Userprofilecontroller();

  @override
  void initState() {
    userprofilecontroller.init();
    super.initState();
  }

  @override
  void dispose() {
    userprofilecontroller.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileInfoCubit, UserProfileInfoState>(
      builder: (context, state) {
        bool isasync = false;
        if (state is EditUserProfileInfoLoading) {
          isasync = true;
        } else {
          isasync = false;
        }
        return ModalProgressHUD(
          progressIndicator: customloading(),
          inAsyncCall: isasync,
          child: Scaffold(
            backgroundColor: ColorManger.reportsPageBackground,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w8,
                      vertical: ScreenUtilsManager.h8,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: ScreenUtilsManager.w40,
                            height: ScreenUtilsManager.h40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorManger.kPrimaryDark,
                              size: ScreenUtilsManager.s24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            Constantmanger.editProfile,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: ScreenUtilsManager.s20,
                              fontWeight: FontWeight.w700,
                              color: ColorManger.kPrimaryDark,
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenUtilsManager.w40),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtilsManager.h32,
                            ),
                            child: Column(
                              children: [
                                Customimagepicker(
                                  userProfile:
                                      userprofilecontroller.userProfile,
                                  onTap: () async {
                                    final image = await ImagePickerMenu.show(
                                      context,
                                    );

                                    print(image);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Editfromprofile(
                            EmailCotroller:
                                userprofilecontroller.emailController,
                            nameCotroller: userprofilecontroller.nameController,
                            phoneCotroller:
                                userprofilecontroller.phoneController,
                            addressCotroller:
                                userprofilecontroller.addressController,
                          ),
                          const SizedBox(height: 16),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtilsManager.p10,
                              horizontal: ScreenUtilsManager.p23,
                            ),
                            child: Chanagepassword(),
                          ),

                          SizedBox(height: ScreenUtilsManager.h24),
                          Saveeditprofile(
                            ontap: () {
                              context
                                  .read<UserProfileInfoCubit>()
                                  .updateUserProfile(
                                    UserProfile(
                                      fullName: userprofilecontroller
                                          .nameController
                                          .text,
                                      nationalId: userprofilecontroller
                                          .userProfile
                                          .nationalId,
                                      address: userprofilecontroller
                                          .addressController
                                          .text,
                                      phoneNumber: userprofilecontroller
                                          .phoneController
                                          .text,
                                      email: userprofilecontroller
                                          .emailController
                                          .text,
                                    ),
                                  );
                            },
                            bntcontroller: userprofilecontroller.bntController,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your data is securely stored and encrypted.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, UserProfileInfoState state) {
        if (state is EditUserProfileInfoError) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.message,
          );
        }
        if (state is EditUserProfileInfoSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.green,
            message: state.user.username.toString(),
          );
        }
      },
    );
  }
}
