import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart'; // تم الإضافة
import 'package:citifix/generated/l10n.dart'; // تم الإضافة
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/taskdetailsmodel.dart';

class TaskInfoSection extends StatelessWidget {
  final TaskDetailsModel task;

  const TaskInfoSection({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w20),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        border: Border.all(color: ColorManger.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${S.of(context).idLabel}: #${task.id}',
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s10,
                  fontWeight: FontWeight.w500,
                  color: ColorManger.grey500,
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          Text(
            task.title ?? S.of(context).noTitle,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s20,
              fontWeight: FontWeight.w800,
              color: ColorManger.onSurface,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h8),
          Text(
            task.description ?? S.of(context).noDescription,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              color: ColorManger.onSurfaceVariant,
              height: ScreenUtilsManager.h1_5,
            ),
          ),
        ],
      ),
    );
  }
}
