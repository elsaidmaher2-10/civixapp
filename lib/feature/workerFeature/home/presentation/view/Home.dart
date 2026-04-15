import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/dashbroadHomemanager/cubit/dashbroad_home_manager_cubit.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/dashbroadHomemanager/cubit/dashbroad_home_manager_state.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/customtaskListView.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/CustomMapSection.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/HomeAppBar.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/WorkAllertVrefication.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/WorkerDashBoard.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/workerCard.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/resource/screenutilsmaanger.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.bgbackground,
      appBar: WorkerMainscreenAppbar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return buildShimmerLoading();
          } else if (state is HomeSuccess) {
            final data = state.dashboardData;
            return _buildHomeContent(data, context);
          } else if (state is HomeError) {
            return _buildErrorWidget(context, state.errorMessage);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHomeContent(DashBroadHome data, BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (notification) => true,
      onRefresh: () {
        return context.read<HomeCubit>().getWorkerDashboard();
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilsManager.s16,
          vertical: ScreenUtilsManager.s24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(data.workerName, context),
            SizedBox(height: ScreenUtilsManager.s16),
            WorkerCard(
              isVerified: data.verified,
              name: data.workerName,
              imageUrl: data.profileImageUrl ?? AssetValueManager.defualtimage1,
            ),
            SizedBox(height: ScreenUtilsManager.s16),
            if (!data.verified) WorkerAlertVrefication(),
            SizedBox(height: ScreenUtilsManager.s16),
            WorkerDashboard(data: data),
            SizedBox(height: ScreenUtilsManager.s24),
            CustomMapSection(
              zonemLevel: data.areaCoordinates,
              areaname: data.areaName,
            ),
            SizedBox(height: ScreenUtilsManager.s24),
            data.recentReports.isEmpty
                ? _buildEmptyTasksMessage(context)
                : CustomTaskListView(reports: data.recentReports),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(String name, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${S.of(context).welcome_message}$name",
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s32,
            fontWeight: FontWeight.w800,
            color: ColorManger.onSurface,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.s4),
        Text(
          S.of(context).stay_focused,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s16,
            fontWeight: FontWeight.w500,
            color: ColorManger.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Color.fromRGBO(224, 224, 224, 1),
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenUtilsManager.s16),
        child: Column(
          children: List.generate(
            4,
            (index) => Container(
              margin: EdgeInsets.only(bottom: ScreenUtilsManager.s20),
              height: ScreenUtilsManager.h150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenUtilsManager.s16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: ScreenUtilsManager.s60,
            color: Colors.redAccent,
          ),
          SizedBox(height: ScreenUtilsManager.s16),
          Text(
            message,
            style: GoogleFonts.cairo(fontSize: ScreenUtilsManager.s16),
          ),
          TextButton(
            onPressed: () => context.read<HomeCubit>().getWorkerDashboard(),
            child: Text(
              S.of(context).retry,
              style: GoogleFonts.cairo(color: ColorManger.kPrimaryDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTasksMessage(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenUtilsManager.s20),
      decoration: BoxDecoration(
        color: ColorManger.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.s12),
        border: Border.all(color: ColorManger.outline),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_turned_in_outlined,
            size: ScreenUtilsManager.s40,
            color: ColorManger.secondary,
          ),
          SizedBox(height: ScreenUtilsManager.s10),
          Text(
            S.of(context).no_tasks_available,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s16,
            ),
          ),
          Text(S.of(context).notify_new_tasks),
        ],
      ),
    );
  }
}
