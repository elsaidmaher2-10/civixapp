import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepHeader extends StatelessWidget {
  final String title;
  final String stepLabel;

  const StepHeader({super.key, required this.title, required this.stepLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s20,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurface,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilsManager.w12,
            vertical: ScreenUtilsManager.h6,
          ),
          decoration: BoxDecoration(
            color: context.palette.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
            border: Border.all(color: context.palette.outline.withOpacity(0.2)),
          ),
          child: Text(
            stepLabel.toUpperCase(),
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s10,
              fontWeight: FontWeight.w800,
              color: context.palette.workerprimary,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}
