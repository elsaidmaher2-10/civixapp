import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanagerAr.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/CustomMapSection.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/CustomtaskListView.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/HomeAppBar.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/WorkAllertVrefication.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/WorkerDashBoard.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/workerCard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.bgbackground,
      appBar: homeAppbar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilsManager.w16,
          vertical: ScreenUtilsManager.h24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constantmanger.welceommsg,
              style: TextStyle(
                fontSize: ScreenUtilsManager.s32,
                fontWeight: FontWeight.w800,
                color: ColorManger.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h4),
            Text(
              Constantmanagerar.stayfocus,
              style: TextStyle(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.w500,
                color: ColorManger.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            WorkerCard(),
            SizedBox(height: ScreenUtilsManager.h16),
            WorkerAlertVrefication(),
            SizedBox(height: ScreenUtilsManager.h16),
            WorkerDashboard(),
            SizedBox(height: ScreenUtilsManager.h24),
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
