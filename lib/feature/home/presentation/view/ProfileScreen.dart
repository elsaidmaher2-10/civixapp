import 'dart:async';
import 'dart:io';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/home/data/Repos/UserProfileRepos/userprofileRepos.dart';
import 'package:citifix/feature/home/presentation/manager/cubit/user_profile_info_cubit.dart';
import 'package:citifix/feature/home/presentation/view/widget/ProfileInfo.dart';
import 'package:citifix/feature/home/presentation/view/widget/profileSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

StreamController<File?> iamgePicker = StreamController.broadcast();
File? _image;
final ImagePicker _picker = ImagePicker();
Future<void> _pickImage(ImageSource source) async {
  final XFile? pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
    _image = File(pickedFile.path);
    iamgePicker.add(_image);
  }
}

void _showPickerMenu(BuildContext context) async {
  PopupMenuItem<String> _buildMenuItem({
    required String value,
    required String label,
    IconData? icon,
    Color? iconColor,
    Color? iconBgColor,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(4),
        child: ListTile(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          selectedColor: Colors.transparent,
          selectedTileColor: Colors.transparent,
          enableFeedback: false,
          horizontalTitleGap: 8,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          leading: icon != null
              ? CircleAvatar(
                  radius: 12,
                  backgroundColor:
                      iconBgColor ?? Color(0xff1162D4).withOpacity(0.5),
                  child: Icon(icon, color: iconColor ?? Colors.white, size: 12),
                )
              : null,
          title: Text(label),
        ),
      ),
    );
  }

  final selected = await showMenu<String>(
    shadowColor: Colors.white,
    color: Colors.white,
    context: context,
    position: const RelativeRect.fromLTRB(100, 200, 0, 0),
    surfaceTintColor: Colors.transparent,
    items: [
      _buildMenuItem(value: 'camera', label: 'Camera', icon: Icons.camera_alt),
      _buildMenuItem(
        value: 'gallery',
        label: 'Gallery',
        icon: Icons.photo_library,
      ),
      _buildMenuItem(
        value: 'cancel',
        label: 'Cancel',
        icon: Icons.close,
        iconBgColor: Colors.grey,
      ),
    ],
  );

  if (selected == 'camera') {
    _pickImage(ImageSource.camera);
  }
  if (selected == 'gallery') {
    _pickImage(ImageSource.gallery);
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => UserProfileInfoCubit(getIt<Userprofilerepos>()),

        child: Scaffold(
          backgroundColor: ColorManger.white,
          appBar: AppBar(
            backgroundColor: ColorManger.white,
            title: Text(
              Constantmanger.proile,
              style: GoogleFonts.inter(
                color: ColorManger.kprimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProfileInfo(
                  onTap: () {
                    _showPickerMenu(context);
                  },
                ),
                ProfileSettings(),
                SizedBox(height: ScreenUtilsManager.h16),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w32,
                  ),
                  child: CustomButton(
                    onPressed: () {},
                    icon: Icon(Icons.logout),
                    backgroundColor: ColorManger.redlight,
                    foregroundColor: ColorManger.red,
                    lable: Constantmanger.sendReport,
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
