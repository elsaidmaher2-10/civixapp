import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/MainscreenAppbar.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/GetAllReport.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ReportCard.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/statusCard.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.reportsPageBackground,
      appBar: const MainscreenAppbar(),
      body: BlocBuilder<ReportCubit, ReportManagerState>(
        builder: (context, state) {
          if (state is GetReportsLoading || state is deleteReportState) {
            return const Center(
              child: SpinKitWaveSpinner(color: ColorManger.lightColor),
            );
          }
          if (state is GetReportsFailure) {
            return Center(child: _buildErrorWidget(context, state.errMessage));
          }
          List<ReportItem> reports = [];
          if (state is GetReportsSuccess) {
            reports = state.reports;
          }

          final int completedCount = reports
              .where((e) => e.status.toLowerCase() == "resolved")
              .length;
          final int pendingCount = reports
              .where((e) => e.status.toLowerCase() == "pending")
              .length;
          final int activeCount = reports
              .where((e) => e.status == "InProgress")
              .length;

          return RefreshIndicator.adaptive(
            backgroundColor: Colors.white,
            color: ColorManger.lightBlue,
            onRefresh: () async {
              await context.read<ReportCubit>().fetchReports();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtilsManager.h24),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetValueManager.overVeiw,
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(width: ScreenUtilsManager.w8),
                        Text(
                          S.of(context).overview,
                          style: GoogleFonts.cairo(
                            letterSpacing: -0.5,
                            color: ColorManger.kPrimaryDark,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtilsManager.s20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenUtilsManager.h16),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: StatusCard(
                            color: ColorManger.kPrimary,
                            number: activeCount,
                            title: S.of(context).active,
                            iconPath: AssetValueManager.active,
                            iconcolor: ColorManger.kPrimary,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: StatusCard(
                            color: ColorManger.orange,
                            number: pendingCount,
                            title: S.of(context).pending,
                            iconPath: AssetValueManager.pending,
                            iconcolor: ColorManger.orange,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: StatusCard(
                            number: completedCount,
                            title: S.of(context).completed,
                            iconPath: AssetValueManager.resolved,
                            color: ColorManger.green,
                            iconcolor: ColorManger.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ScreenUtilsManager.h32),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.w16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).recentReport,
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                            color: ColorManger.kPrimaryDark,
                          ),
                        ),
                        if (reports.isNotEmpty)
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<ReportCubit>(),
                                    child: ReportsPage(),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).seeAll,
                              style: GoogleFonts.cairo(
                                fontSize: ScreenUtilsManager.s14,
                                fontWeight: FontWeight.w600,
                                color: ColorManger.lightBlue,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: ScreenUtilsManager.h16),

                  if (reports.isEmpty)
                    _buildEmptyState(context)
                  else
                    ListView.separated(
                      key: ValueKey(reports.length),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        left: ScreenUtilsManager.w16,
                        right: ScreenUtilsManager.w16,
                        bottom: ScreenUtilsManager.h40,
                      ),
                      itemCount: reports.length > 3 ? 3 : reports.length,
                      itemBuilder: (context, index) =>
                          Reportcard(report: reports[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: ScreenUtilsManager.h12),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h40),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w24),
              decoration: BoxDecoration(
                color: ColorManger.lightColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 48.r,
                color: ColorManger.lightColor,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            Text(
              S.of(context).noRecentReports, // ARB
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.bold,
                color: ColorManger.kPrimaryDark,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              S.of(context).emptyReportsSubtitle, // ARB
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildErrorWidget(BuildContext context, String message) {
  return Padding(
    padding: EdgeInsets.all(20.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        message.contains(Constantmanger.nointernet)
            ? Icon(Icons.cloud_off, size: 64.w, color: Colors.grey)
            : Icon(Icons.error, size: 64.w, color: Colors.grey),
        SizedBox(height: 16.h),
        Text(
          S.of(context).errorOccurred,
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(color: Colors.grey),
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: () => context.read<ReportCubit>().fetchReports(),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManger.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(S.of(context).retry),
        ),
      ],
    ),
  );
}
