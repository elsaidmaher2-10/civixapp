import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainscreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainscreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SvgPicture.asset(
            AssetValueManager.citifixicon,
            width: ScreenUtilsManager.w32,
            height: ScreenUtilsManager.h32,
          ),
          SizedBox(width: 5.w),
          Text(
            Constantmanger.apptitle,
            style: GoogleFonts.publicSans(
              color: ColorManger.kprimarydark,
              fontWeight: FontWeight.w700,
              fontSize: ScreenUtilsManager.s20,
            ),
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        SvgPicture.asset(
          AssetValueManager.notifcationenabled,
          width: ScreenUtilsManager.w32,
          height: ScreenUtilsManager.h36,
        ),
        SizedBox(width: ScreenUtilsManager.w18),
      ],
      toolbarHeight: ScreenUtilsManager.h61,
      backgroundColor: Color(0xffE2E8F0),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilsManager.h61);
}
