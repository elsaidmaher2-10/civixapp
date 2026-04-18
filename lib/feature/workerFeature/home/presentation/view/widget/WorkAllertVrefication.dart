import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerAlertVrefication extends StatelessWidget {
  const WorkerAlertVrefication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.h20),
      decoration: BoxDecoration(
        color: context.palette.primaryColor.withValues(alpha: 0.05),
        border: Border.all(color: context.palette.primaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
      ),
      child: Row(
        children: [
          Container(
            width: ScreenUtilsManager.w40,
            height: ScreenUtilsManager.h40,
            decoration: BoxDecoration(
              color: context.palette.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.report_problem, color: context.palette.primaryColor),
          ),
          SizedBox(width: ScreenUtilsManager.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).alertRequired,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: context.palette.primaryColor,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h4),
                Text(
                  S.of(context).updateYourId,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    color: context.palette.onInProgressContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
