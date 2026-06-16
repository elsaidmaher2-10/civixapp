import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.palette.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: context.palette.onSurface,
          size: ScreenUtilsManager.s20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        S.of(context).taskDetails,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w800,
          color: context.palette.onSurface,
          fontSize: ScreenUtilsManager.s18,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
