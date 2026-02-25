import 'dart:io';

import 'package:citifix/core/function/imagebutton.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/imagepickerservice.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

void showSignupImageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) => Wrap(
      children: [
        Appbutton(
          onPressed: () async {
            File? image = await imagepickerservice(
              context,
              ImageSource.gallery,
            );
            context.read<SingupCubit>().imagepickerstate(image);
            Navigator.pop(ctx);
          },
          text: Constantmanger.photoGallery,
        ),

        Divider(height: 2, color: ColorManger.white, thickness: 2),

        Appbutton(
          onPressed: () async {
            File? image = await imagepickerservice(context, ImageSource.camera);
            context.read<SingupCubit>().imagepickerstate(image);
            Navigator.pop(ctx);
          },
          text: Constantmanger.camera,
        ),

        SizedBox(height: 10.h),

        Appbutton(
          onPressed: () => Navigator.pop(ctx),
          color: ColorManger.white,
          text: Constantmanger.cancel,
        ),
      ],
    ),
  );
}
