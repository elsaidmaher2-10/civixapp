import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/widget/CustomMapSection.dart';
import 'package:citifix/feature/workerFeature/home/widget/CustomtaskListView.dart';
import 'package:citifix/feature/workerFeature/home/widget/HomeAppBar.dart';
import 'package:citifix/feature/workerFeature/home/widget/WorkAllertVrefication.dart';
import 'package:citifix/feature/workerFeature/home/widget/WorkerDashBoard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.bgbackground,
      appBar: homeAppbar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Alex',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: ColorManger.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Stay focused and keep delivering',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManger.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            WorkerCard(),
            const SizedBox(height: 16),
            WorkerAlertVrefication(),
            const SizedBox(height: 16),
            WorkerDashboard(),
            const SizedBox(height: 24),
            CustomMapSection(),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            CustomtaskListView(),
          ],
        ),
      ),
    );
  }
}
