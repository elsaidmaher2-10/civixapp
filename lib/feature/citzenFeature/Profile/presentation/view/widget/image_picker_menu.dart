import 'dart:io';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/controller/imageController.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerMenu {
  const ImagePickerMenu._();

  static Future<File?> show(BuildContext context) async {
    final selected = await showMenu<String>(
      shadowColor: ColorManger.white,
      color: ColorManger.white,
      context: context,
      position: RelativeRect.fromLTRB(
        ScreenUtilsManager.menuLeft,
        ScreenUtilsManager.menuTop,
        ScreenUtilsManager.menuRight,
        ScreenUtilsManager.menuBottom,
      ),
      surfaceTintColor: Colors.transparent,
      items: [
        _buildMenuItem(
          value: 'camera',
          label: S.of(context).camera,
          icon: Icons.camera_alt,
        ),
        _buildMenuItem(
          value: 'gallery',
          label: S.of(context).photoGallery,
          icon: Icons.photo_library,
        ),
        _buildMenuItem(
          value: 'cancel',
          label: S.of(context).cancel,
          icon: Icons.close,
          iconBgColor: ColorManger.lightGrey2,
        ),
      ],
    );

    if (selected == 'camera') {
      return ImagePickerController().pickImage(ImageSource.camera);
    }
    if (selected == 'gallery') {
      return ImagePickerController().pickImage(ImageSource.gallery);
    }
    return null;
  }

  static PopupMenuItem<String> _buildMenuItem({
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
          color: ColorManger.lightGrey5,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
        ),
        margin: EdgeInsets.all(ScreenUtilsManager.h4),
        child: ListTile(
          horizontalTitleGap: ScreenUtilsManager.w8,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtilsManager.w4,
          ),
          leading: icon != null
              ? CircleAvatar(
                  radius: ScreenUtilsManager.r12,
                  backgroundColor:
                      iconBgColor ?? ColorManger.lightBlue.withOpacity(0.5),
                  child: Icon(
                    icon,
                    color: iconColor ?? ColorManger.white,
                    size: ScreenUtilsManager.s12,
                  ),
                )
              : null,
          title: Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              color: ColorManger.textBlack,
            ),
          ),
        ),
      ),
    );
  }
}
