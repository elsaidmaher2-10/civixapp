import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart'; // تم الإضافة
import 'package:citifix/generated/l10n.dart'; // تم الإضافة
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:citifix/feature/workerFeature/taskDetails/data/model/taskdetailsmodel.dart';

class TaskOwnerHeader extends StatelessWidget {
  final TaskDetailsModel task;

  const TaskOwnerHeader({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.w16),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        border: Border.all(color: context.palette.grey200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(ScreenUtilsManager.w2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.palette.orange,
                        width: ScreenUtilsManager.w2,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.w2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenUtilsManager.r50),
                        child: CachedNetworkImage(
                          imageUrl:
                              task.citizenProfileImageUrl ??
                              AssetValueManager.defualtimage1,
                          width: ScreenUtilsManager.w60,
                          height: ScreenUtilsManager.h60,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            width: ScreenUtilsManager.w60,
                            height: ScreenUtilsManager.h60,
                            color: context.palette.grey200,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.person, size: ScreenUtilsManager.s24),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(ScreenUtilsManager.w2),
                      decoration: BoxDecoration(
                        color: context.palette.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        color: context.palette.white,
                        size: ScreenUtilsManager.s12,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(width: ScreenUtilsManager.w12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.citizenName,
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtilsManager.s14,
                    ),
                  ),
                  SizedBox(height: ScreenUtilsManager.h2),

                  Text(
                    S.of(context).taskOwnerLabel,
                    style: GoogleFonts.cairo(
                      color: context.palette.onSurfaceVariant,
                      fontSize: ScreenUtilsManager.s12,
                    ),
                  ),
                ],
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                S.of(context).created,
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s10,
                  fontWeight: FontWeight.bold,
                  color: context.palette.grey400,
                  letterSpacing: ScreenUtilsManager.s1,
                ),
              ),
              SizedBox(height: ScreenUtilsManager.h2),

              Text(
                DateTime.parse(task.createdAt).timeAgo(context),
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🧠 simple date formatter
  String _formatDate(String? date, BuildContext context) {
    if (date == null) return S.of(context).unknown;

    try {
      final dt = DateTime.parse(date);
      final diff = DateTime.now().difference(dt);

      if (diff.inMinutes < 60) {
        return S.of(context).minutesAgo(diff.inMinutes);
      } else if (diff.inHours < 24) {
        return S.of(context).hoursAgo(diff.inHours);
      } else {
        return S.of(context).daysAgo(diff.inDays);
      }
    } catch (e) {
      return date;
    }
  }
}
