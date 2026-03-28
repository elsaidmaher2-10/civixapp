import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationinit.dart';
import 'package:flutter/material.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tasks',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
            fontSize: 36,
            color: ColorManger.onSurface,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage your work efficiently',
          style: TextStyle(fontSize: 18, color: ColorManger.secondary),
        ),
      ],
    );
  }
}
