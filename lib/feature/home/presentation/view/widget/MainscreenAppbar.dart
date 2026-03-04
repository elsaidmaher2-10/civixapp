import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainscreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainscreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        Constantmanger.apptitle,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: ScreenUtilsManager.s32,
        ),
      ),
      actions: [
        Icon(
          CupertinoIcons.bell,
          color: Colors.white,
          size: ScreenUtilsManager.w24,
        ),
        SizedBox(width: ScreenUtilsManager.w18),
      ],
      toolbarHeight: ScreenUtilsManager.h70,
      leading: const SizedBox.shrink(),
      backgroundColor: ColorManger.kprimary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilsManager.h70);
}
