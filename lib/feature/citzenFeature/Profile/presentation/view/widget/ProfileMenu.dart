import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuItem extends StatelessWidget {
  final Widget iconPath;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withValues(alpha: 0.35)
                    : Colors.white30,
                offset: const Offset(2, 10),
                blurRadius: 15,
              ),
            ],
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
            border: BoxBorder.all(color: context.palette.lightGrey4, width: 2.w),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: ScreenUtilsManager.w8,
            ),
            onTap: onTap,
            leading: iconPath,
            title: Text(
              title,
              style: GoogleFonts.cairo(color: context.palette.onSurface),
            ),
            trailing: RotatedBox(
              quarterTurns: 90,
              child: Icon(
                CupertinoIcons.back,
                color: context.palette.onSurfaceVariant,
              ),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h10),
      ],
    );
  }
}
