import 'dart:convert';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/EditFromProfile.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/chanagePassword.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/customImagePicker.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/image_picker_menu.dart';
import 'package:citifix/feature/Profile/presentation/view/widget/saveeditProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _WorkerEditProfileScreenState();
}

class _WorkerEditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late UserProfile userProfile;
  @override
  void initState() {
    String? userinfoStr = PrefrenceManager().getstring("user_profile_data");

    if (userinfoStr != null) {
      userProfile = UserProfile.fromJson(jsonDecode(userinfoStr));
    }
    _emailController = TextEditingController(text: userProfile.email);
    _phoneController = TextEditingController(text: userProfile.phoneNumber);
    _nameController = TextEditingController(text: userProfile.fullName);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.bgLight,
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
                            userProfile: userProfile,
                            onTap: () async {
                              final image = await ImagePickerMenu.show(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Editfromprofile(
                      EmailCotroller: _emailController,
                      nameCotroller: _nameController,
                      phoneCotroller: _phoneController,
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
                    Saveeditprofile(),
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
    );
  }
}
