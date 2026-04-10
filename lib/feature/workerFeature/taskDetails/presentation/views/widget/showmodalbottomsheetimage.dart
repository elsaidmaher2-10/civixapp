import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/function/imagebutton.dart';
import '../../../../../../core/resource/colormanager.dart';
import '../../../../../../core/service/imagepickerservice.dart';
import '../../../../../../generated/l10n.dart';

Future<List<File>?> showImageBottomSheet(BuildContext context) async {
  return await showModalBottomSheet<List<File>?>(
    barrierColor: Colors.transparent,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (ctx) => Wrap(
      children: [
        AppButton(
          text: S.of(context).photoGallery,
          onPressed: () async {
            List<File>? images = await imagepickerMultiimage(context);
            if (ctx.mounted) {
              Navigator.pop(ctx, images);
            }
          },
        ),
        AppButton(
          text: S.of(context).camera,
          onPressed: () async {
            File? image = await imagepickerservice(context, ImageSource.camera);
            if (ctx.mounted) {
              Navigator.pop(ctx, image != null ? [image] : null);
            }
          },
        ),
        Divider(height: 0.3, color: ColorManger.white, thickness: 1),
        AppButton(
          onPressed: () => Navigator.pop(ctx),
          text: S.of(context).cancel,
        ),
      ],
    ),
  );
}
