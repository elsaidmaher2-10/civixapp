import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomAnimatedSearch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportSearchBar extends StatelessWidget {
  const ReportSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ScreenUtilsManager.h20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Achievement",
            style: GoogleFonts.inter(
              color: ColorManger.kPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h40),
          CustomSearchField(),
        ],
      ),
    );
  }
}
