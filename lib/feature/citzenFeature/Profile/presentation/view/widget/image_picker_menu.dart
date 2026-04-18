import 'dart:io';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/cubit/controller/imageController.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerMenu {
  const ImagePickerMenu._();

  static Future<File?> show(BuildContext context) async {
    final selected = await showMenu<String>(
      shadowColor: context.palette.white,
      color: context.palette.white,
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
          context,
          value: 'camera',
          label: S.of(context).camera,
          icon: Icons.camera_alt,
        ),
        _buildMenuItem(
          context,
          value: 'gallery',
          label: S.of(context).photoGallery,
          icon: Icons.photo_library,
        ),
        _buildMenuItem(
          context,
          value: 'cancel',
          label: S.of(context).cancel,
          icon: Icons.close,
          iconBgColor: context.palette.lightGrey2,
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

  static PopupMenuItem<String> _buildMenuItem(
    BuildContext context, {
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
          color: context.palette.lightGrey5,
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
                      iconBgColor ?? context.palette.lightBlue.withOpacity(0.5),
                  child: Icon(
                    icon,
                    color: iconColor ?? context.palette.white,
                    size: ScreenUtilsManager.s12,
                  ),
                )
              : null,
          title: Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              color: context.palette.textBlack,
            ),
          ),
        ),
      ),
    );
  }
}
