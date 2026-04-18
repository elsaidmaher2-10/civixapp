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
    return await showModalBottomSheet<File?>(
      context: context,
      backgroundColor: context.palette.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenUtilsManager.r20),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h16),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                Container(
                  width: ScreenUtilsManager.w40,
                  height: ScreenUtilsManager.h4,
                  decoration: BoxDecoration(
                    color: context.palette.lightGrey2,
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h20),

                _buildListTile(
                  context,
                  label: S.of(context).camera,
                  icon: Icons.camera_alt,
                  onTap: () async {
                    final file = await ImagePickerController().pickImage(
                      ImageSource.camera,
                    );
                    Navigator.pop(context, file);
                  },
                ),
                _buildListTile(
                  context,
                  label: S.of(context).photoGallery,
                  icon: Icons.photo_library,
                  onTap: () async {
                    final file = await ImagePickerController().pickImage(
                      ImageSource.gallery,
                    );
                    Navigator.pop(context, file);
                  },
                ),
                _buildListTile(
                  context,
                  label: S.of(context).cancel,
                  icon: Icons.close,
                  iconBgColor: context.palette.lightGrey2,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildListTile(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
    IconData? icon,
    Color? iconColor,
    Color? iconBgColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.w16,
        vertical: ScreenUtilsManager.h4,
      ),
      decoration: BoxDecoration(
        color: context.palette.lightGrey5,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: icon != null
            ? CircleAvatar(
                radius: ScreenUtilsManager.r18,
                backgroundColor:
                    iconBgColor ?? context.palette.lightBlue.withOpacity(0.5),
                child: Icon(
                  icon,
                  color: iconColor ?? context.palette.white,
                  size: ScreenUtilsManager.s18,
                ),
              )
            : null,
        title: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s16,
            fontWeight: FontWeight.w600,
            color: context.palette.textBlack,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: ScreenUtilsManager.s14,
          color: context.palette.lightGrey2,
        ),
      ),
    );
  }
}
