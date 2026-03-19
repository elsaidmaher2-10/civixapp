import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/feature/Profile/presentation/manager/controller/imageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Customimagepicker extends StatelessWidget {
  const Customimagepicker({super.key, required this.userProfile});
  final UserProfile userProfile;
  final isImageLoading = false;
  @override
  Widget build(BuildContext context) {
    print(userProfile.toJson());
    return Stack(
      clipBehavior: Clip.none,
      children: [
        StreamBuilder<File?>(
          stream: ImagePickerController().stream,
          builder: (context, pickedFile) {
            ImageProvider imageProvider;
            if (pickedFile.data != null) {
              imageProvider = FileImage(pickedFile.data!);
            } else if (userProfile.profileImage != null &&
                userProfile.profileImage!.isNotEmpty) {
              imageProvider = userProfile.profileImage!.startsWith('http')
                  ? CachedNetworkImageProvider(userProfile.profileImage!)
                  : FileImage(File(userProfile.profileImage!));
            } else {
              imageProvider = AssetImage(AssetValueManager.defualtimage);
            }
            return Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 68.r,
                  backgroundColor: ColorManger.lightBlue.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 64.r,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: ColorManger.lightGrey,
                      backgroundImage: imageProvider,
                    ),
                  ),
                ),
                if (isImageLoading)
                  CircleAvatar(
                    radius: 60.r,
                    backgroundColor: Colors.black38,
                    child: SpinKitPouringHourGlassRefined(
                      color: Colors.white,
                      size: 40.h,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
