import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/home/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/home/presentation/view/GetAllReport.dart';
import 'package:citifix/feature/home/presentation/view/widget/MainscreenAppbar.dart';
import 'package:citifix/feature/home/presentation/view/widget/ReportCard.dart';
import 'package:citifix/feature/home/presentation/view/widget/statusCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
// ... (your existing imports)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.Lightgrey5,
      appBar: MainscreenAppbar(),
      body: RefreshIndicator.adaptive(
        backgroundColor: Colors.white,
        color: ColorManger.Lightblue,

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
                  children: [
                    SvgPicture.asset(AssetValueManager.overVeiw),
                    SizedBox(width: ScreenUtilsManager.w8),
                    Text(
                      Constantmanger.overview,
                      style: GoogleFonts.publicSans(
                        letterSpacing: -0.8,
                        color: ColorManger.kprimarydark,
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
                        color: ColorManger.kprimary,
                        number: 15,
                        title: Constantmanger.kActive,
                        iconPath: AssetValueManager.active,
                        iconcolor: ColorManger.kprimary,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: StatusCard(
                        color: ColorManger.orange,
                        number: 10,
                        title: Constantmanger.kPending,
                        iconPath: AssetValueManager.pending,
                        iconcolor: ColorManger.orange,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: StatusCard(
                        number: 20,
                        title: Constantmanger.kCompleted,
                        iconPath: AssetValueManager.resolved,
                        color: ColorManger.green,
                        iconcolor: ColorManger.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilsManager.h22),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w16,
                ),
                child: Row(
                  children: [
                    Text(
                      Constantmanger.recenreport,
                      style: GoogleFonts.publicSans(
                        fontSize: ScreenUtilsManager.s18,
                        fontWeight: FontWeight.bold,
                        color: ColorManger.kprimarydark,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (ctx) => ReportsPage()),
                        );
                      },
                      child: Text(
                        Constantmanger.seeall,
                        style: GoogleFonts.publicSans(
                          fontSize: ScreenUtilsManager.s14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtilsManager.h22),
              BlocBuilder<ReportCubit, ReportManagerState>(
                builder: (context, state) {
                  // 1. معالجة حالة التحميل لأول مرة فقط
                  if (state is GetReportsLoading) {
                    return const Center(
                      child: SpinKitWaveSpinner(color: ColorManger.lightcolor),
                    );
                  }

                  // 2. معالجة حالة الفشل
                  if (state is GetReportsFailure) {
                    return Center(child: Text(state.errMessage));
                  }

                  // 3. عرض البيانات (في حالة النجاح أو في حالة الإضافة)
                  List reports = [];
                  if (state is GetReportsSuccess) {
                    reports = state.reports;
                  } else if (state is CreateReportSuccess ||
                      state is CreateReportLoading) {}

                  if (reports.isEmpty && state is! CreateReportLoading) {
                    return const Center(child: Text("No reports found"));
                  }

                  return ListView.separated(
                    key: ValueKey(reports.length),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 40),
                    itemCount: reports.length > 3 ? 3 : reports.length,
                    itemBuilder: (context, index) =>
                        Reportcard(report: reports[index]),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
