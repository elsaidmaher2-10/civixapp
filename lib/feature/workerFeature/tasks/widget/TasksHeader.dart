import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Tasks',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w800,
                fontSize: ScreenUtilsManager.s32,
                color: ColorManger.onSurface,
                letterSpacing: -1,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: ColorManger.primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.notifications_none,
                color: ColorManger.primaryColor,
              ),
            ),
          ],
        ),
        Text(
          'Keep track of your daily progress',
          style: TextStyle(
            fontSize: ScreenUtilsManager.s15,
            color: ColorManger.onSurfaceVariant.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
