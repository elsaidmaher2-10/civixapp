import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../generated/l10n.dart'; // Ensure correct path

class ReportSearchBar extends StatelessWidget {
  const ReportSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.h10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.achievement,
            style: GoogleFonts.cairo(
              color: ColorManger.kPrimary,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h10),

          // const CustomSearchField(),
        ],
      ),
    );
  }
}
