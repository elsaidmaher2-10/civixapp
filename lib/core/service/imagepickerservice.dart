import 'dart:io';

import 'package:civixapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> imagepickerservice(
  BuildContext context,
  ImageSource source,
) async {
  XFile? file = await ImagePicker().pickImage(source: source);

  if (file != null) {
    BlocProvider.of<SingupCubit>(context).imagepickerstate(File(file.path));
    return File(file.path);
  } else {
    {
      BlocProvider.of<SingupCubit>(context).imagepickerstate(null);
      return null;
    }
  }
}
