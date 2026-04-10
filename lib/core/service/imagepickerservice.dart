import 'dart:async';
import 'dart:io';

import 'package:citifix/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> imagepickerservice(
  BuildContext context,
  ImageSource source,
) async {
  XFile? file = await ImagePicker().pickImage(source: source);

  if (file != null) {
    return File(file.path);
  } else {
    {
      return null;
    }
  }
}

Future<List<File>?> imagepickerMultiimage(BuildContext context) async {
  List<XFile>? file = await ImagePicker().pickMultipleMedia();
  if (file.isNotEmpty) {
    final files = file.map((e) => File(e.path)).toList();
    return files;
  } else {
    return null;
  }
}
