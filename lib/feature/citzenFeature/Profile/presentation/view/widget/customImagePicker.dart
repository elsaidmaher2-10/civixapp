import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/UserProfileModel/userProfile.dart';
import 'package:citifix/core/cubit/controller/imageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Customimagepicker extends StatelessWidget {
  Customimagepicker({
    super.key,
    required this.role,
    required this.userProfile,
    this.imagePickerController,
  });

  bool role;

  final UserProfile? userProfile;
  final ImagePickerController? imagePickerController;

  @override
  Widget build(BuildContext context) {
    final controller = imagePickerController ?? ImagePickerController();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        StreamBuilder<File?>(
          stream: controller.stream,
          builder: (context, snapshot) {
            final pickedFile = snapshot.data;
            final isImageLoading = controller.isLoading;

            ImageProvider imageProvider;
            if (pickedFile != null) {
              imageProvider = FileImage(pickedFile);
            } else if (userProfile?.profileImage != null &&
                userProfile!.profileImage!.isNotEmpty) {
              imageProvider = userProfile!.profileImage!.startsWith('http')
                  ? CachedNetworkImageProvider(userProfile!.profileImage!)
                  : FileImage(File(userProfile!.profileImage!));
            } else {
              imageProvider = AssetImage(AssetValueManager.defualtimage);
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    File? image = await controller.pickImage(
                      ImageSource.camera,
                    );
                    print(image);
                    if (image != null && context.mounted) {
                      await context
                          .read<UserProfileInfoCubit>()
                          .updateUserProfleImage(image);
                    }
                  },
                  child: CircleAvatar(
                    radius: 68.r,
                    backgroundColor: role
                        ? context.palette.workerprimary.withOpacity(0.5)
                        : context.palette.lightBlue.withOpacity(0.5),
                    child: CircleAvatar(
                      radius: 64.r,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: context.palette.lightGrey,
                        backgroundImage: imageProvider,
                        onBackgroundImageError: (_, _) {},
                      ),
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
                role
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.pickImage(ImageSource.camera),
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: role
                                  ? context.palette.workerprimary
                                  : context.palette.primary,

                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
      ],
    );
  }
}
