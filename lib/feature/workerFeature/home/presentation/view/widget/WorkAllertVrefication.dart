import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class WorkerAlertVrefication extends StatelessWidget {
  const WorkerAlertVrefication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.h20),
      decoration: BoxDecoration(
        color: ColorManger.primaryColor.withValues(alpha: 0.05),
        border: Border.all(color: ColorManger.primaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: ScreenUtilsManager.w40,
            height: ScreenUtilsManager.h40,
            decoration: BoxDecoration(
              color: ColorManger.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.report_problem, color: ColorManger.primaryColor),
          ),
          SizedBox(width: ScreenUtilsManager.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constantmanger.alertrequired,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManger.primaryColor,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h4),
                Text(
                  Constantmanger.updateYourID,
                  style: TextStyle(
                    fontSize: ScreenUtilsManager.s14,
                    color: ColorManger.onInProgressContainer,
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
