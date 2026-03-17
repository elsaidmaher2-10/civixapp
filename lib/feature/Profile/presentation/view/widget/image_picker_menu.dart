import 'dart:io';
import 'package:citifix/feature/Profile/presentation/manager/controller/imageController.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerMenu {
  const ImagePickerMenu._();
  static Future<File?> show(BuildContext context) async {
    final selected = await showMenu<String>(
      shadowColor: Colors.white,
      color: Colors.white,
      context: context,
      position: const RelativeRect.fromLTRB(100, 200, 0, 0),
      surfaceTintColor: Colors.transparent,
      items: [
        _buildMenuItem(
          value: 'camera',
          label: 'Camera',
          icon: Icons.camera_alt,
        ),
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
          color: const Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(4),
        child: ListTile(
          horizontalTitleGap: 8,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          leading: icon != null
              ? CircleAvatar(
                  radius: 12,
                  backgroundColor:
                      iconBgColor ?? const Color(0xff1162D4).withOpacity(0.5),
                  child: Icon(icon, color: iconColor ?? Colors.white, size: 12),
                )
              : null,
          title: Text(label),
        ),
      ),
    );
  }
}
