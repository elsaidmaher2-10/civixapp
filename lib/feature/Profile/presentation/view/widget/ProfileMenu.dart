import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    Key? key,
    required this.iconPath,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white30,
                offset: Offset(2, 10),
                blurRadius: 15,
              ),
            ],
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
            border: BoxBorder.all(color: ColorManger.lightGrey4, width: 2.w),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtilsManager.w8,
            ),
            onTap: onTap,
            leading: SvgPicture.asset(
              iconPath,
              colorFilter: ColorFilter.mode(
                ColorManger.lightBlue.withOpacity(0.1),
                BlendMode.srcATop,
              ),
            ),
            title: Text(title),
            trailing: RotatedBox(
              quarterTurns: 90,
              child: Icon(CupertinoIcons.back),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h10),
      ],
    );
  }
}
