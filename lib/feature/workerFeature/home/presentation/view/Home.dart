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
      backgroundColor: context.palette.bgbackground,
      appBar: WorkerMainscreenAppbar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return buildShimmerLoading(context);
          } else if (state is HomeSuccess) {
            final data = state.dashboardData;
            return _buildHomeContent(data, context);
          } else if (state is HomeError) {
            return _buildErrorState(context, state.errorMessage);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      key: const Key('error'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.palette.error.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 50,
                color: context.palette.error,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              S.of(context).errorTitle,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.bold,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: context.palette.onSurfaceVariant,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.palette.workerprimary,
                foregroundColor: context.palette.onPrimary,
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w24,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => context.read<HomeCubit>().getWorkerDashboard(),

              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(
                S.of(context).tryAgain,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildHomeContent(DashBroadHome data, BuildContext context) {
  return RefreshIndicator(
    color: context.palette.workerprimary,
    backgroundColor: context.palette.surfaceContainerLowest,
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
            isVerified: false,
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
          color: context.palette.onSurface,
        ),
      ),
      SizedBox(height: ScreenUtilsManager.s4),
      Text(
        S.of(context).stay_focused,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s16,
          fontWeight: FontWeight.w500,
          color: context.palette.onSurfaceVariant,
        ),
      ),
    ],
  );
}

Widget buildShimmerLoading(BuildContext context) {
  final Color base = context.palette.surfaceContainerHigh;
  final Color highlight = context.palette.surfaceContainerHighest;
  return Shimmer.fromColors(
    baseColor: base,
    highlightColor: highlight,
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
              color: base,
              borderRadius: BorderRadius.circular(ScreenUtilsManager.s16),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildEmptyTasksMessage(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(ScreenUtilsManager.s20),
    decoration: BoxDecoration(
      color: context.palette.white,
      borderRadius: BorderRadius.circular(ScreenUtilsManager.s12),
      border: Border.all(color: context.palette.outline),
    ),
    child: Column(
      children: [
        Icon(
          Icons.assignment_turned_in_outlined,
          size: ScreenUtilsManager.s40,
          color: context.palette.secondary,
        ),
        SizedBox(height: ScreenUtilsManager.s10),
        Text(
          S.of(context).no_tasks_available,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtilsManager.s16,
            color: context.palette.onSurface,
          ),
        ),
        Text(
          S.of(context).notify_new_tasks,
          style: GoogleFonts.cairo(color: context.palette.onSurfaceVariant),
        ),
      ],
    ),
  );
}
