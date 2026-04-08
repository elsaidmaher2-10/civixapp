import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanagerAr.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
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
import 'package:latlong2/latlong.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.bgbackground,
      appBar: homeAppbar(context),
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
          return const SizedBox.shrink();
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
          horizontal: ScreenUtilsManager.w16,
          vertical: ScreenUtilsManager.h24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(data.workerName),
            SizedBox(height: ScreenUtilsManager.h16),
            WorkerCard(
              isVerified: data.verified,
              name: data.workerName,
              imageUrl: data.profileImageUrl,
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            if (!data.verified) const WorkerAlertVrefication(),
            SizedBox(height: ScreenUtilsManager.h16),
            WorkerDashboard(data: data),
            SizedBox(height: ScreenUtilsManager.h24),
            CustomMapSection(
              zonemLevel: data.areaCoordinates,
              areaname: data.areaName,
            ),
            const SizedBox(height: 24),

            data.recentReports.isEmpty
                ? _buildEmptyTasksMessage()
                : CustomTaskListView(reports: data.recentReports),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constantmanger.welceommsg + name,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s32,
            fontWeight: FontWeight.w800,
            color: ColorManger.onSurface,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h4),
        Text(
          Constantmanagerar.stayfocus,
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
      baseColor: const Color.fromRGBO(224, 224, 224, 1),
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
          const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
          const SizedBox(height: 16),
          Text(message, style: GoogleFonts.cairo(fontSize: 16)),
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

  Widget _buildEmptyTasksMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManger.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManger.outline),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_turned_in_outlined,
            size: 40,
            color: ColorManger.secondary,
          ),
          const SizedBox(height: 10),
          Text(
            "No tasks available right now",
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Text("We'll notify you when new tasks arrive."),
        ],
      ),
    );
  }
}
