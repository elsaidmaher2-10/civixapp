import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorsnackbar(
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 63, 63),
      dismissDirection: DismissDirection.vertical,
      content: Text(
        Constantmanger.imagerequired,
        style: TextStyle(
          color: ColorManger.white,
          fontSize: ScreenUtilsManager.h16,
        ),
      ),
    ),
  );
}
