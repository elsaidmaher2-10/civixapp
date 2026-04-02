import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/core/widget/stautsBageApp.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_cubit.dart'; // تأكد من المسار
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/CustomTimelineTile.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ReportDetailsAppbar.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/commentsystem.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import '../../data/repos/commentRepo/commentRepo.dart';

class ReportDetailsScreen extends StatefulWidget {
  final int reportId;
  const ReportDetailsScreen({super.key, required this.reportId});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ReportCubit>().GetReportByID(ReportID: widget.reportId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Future.delayed(Duration.zero, () {
            if (context.mounted) {
              context.read<ReportCubit>().fetchReports();
            }
          });
        }
      },
      child: BlocProvider(
        create: (context) =>
            CommentsCubit(getIt<Commentrepo>())..fetchComments(widget.reportId),
        child: Scaffold(
          backgroundColor: ColorManger.reportsPageBackground,
          body: BlocBuilder<ReportCubit, ReportManagerState>(
            builder: (context, state) {
              if (state is GetReportsByidLoading) {
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: ScreenUtilsManager.r12,
                    color: ColorManger.kPrimary,
                  ),
                );
              } else if (state is GetReportsByidSuccess) {
                final report = state.reports;
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    ReportDetailsAppbar(
                      image: report.imagesUrls.isEmpty
                          ? [Constantmanger.defualtImage]
                          : report.imagesUrls,
                      ontap: () => Navigator.pop(context, true),
                    ),

                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatusBadgeApp(status: report.status),
                            SizedBox(height: 16.h),
                            Text(
                              report.title,
                              style: GoogleFonts.cairo(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w900,
                                color: ColorManger.kPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                _buildInfoChip(
                                  Icons.category_outlined,
                                  report.categoryName,
                                ),
                                SizedBox(width: 16.w),
                                _buildInfoChip(
                                  Icons.access_time_rounded,
                                  report.createdAt.timeAgo(context),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            _buildCitizenCard(context, report.citizenName),
                            SizedBox(height: 20.h),
                            _sectionTitle(S.of(context).description),
                            SizedBox(height: 8.h),
                            Text(
                              report.description,
                              style: GoogleFonts.cairo(
                                fontSize: 15.sp,
                                color: Colors.black87.withOpacity(0.7),
                                height: 1.6,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            _sectionTitle(S.of(context).location),
                            SizedBox(height: 4.h),
                            Text(
                              report.location,
                              style: GoogleFonts.cairo(
                                fontSize: 13.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            _buildMapSection(
                              LatLng(report.latitude, report.longitude),
                              report.location,
                            ),
                            SizedBox(height: 24.h),
                            _sectionTitle(S.of(context).progressTracking),
                            SizedBox(height: 12.h),
                            _buildTimeline(context, report.status),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),

                    Commentsystem(controller: controller, reporID: report.id),
                  ],
                );
              } else if (state is GetReportsByidFailure) {
                return _buildErrorState(context, state.errMessage);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: ColorManger.kPrimary,
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.sp, color: Colors.grey[600]),
        SizedBox(width: 4.w),
        Text(
          label,
          style: GoogleFonts.cairo(fontSize: 13.sp, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildCitizenCard(BuildContext context, String name) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: ColorManger.kPrimary.withOpacity(0.1),
            child: const Icon(
              Icons.person_outline,
              color: ColorManger.kPrimary,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).reportedBy,
                style: GoogleFonts.cairo(fontSize: 11.sp, color: Colors.grey),
              ),
              Text(
                name,
                style: GoogleFonts.cairo(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, String currentStatus) {
    int currentIndex = StatusReport.fromString(currentStatus).index;
    return Column(
      children: List.generate(4, (index) {
        return CustomTimelineTile(
          title: _getStepTitle(context, index),
          isFirst: index == 0,
          isDone: currentIndex >= index,
          isLast: index == 4 - 1,
        );
      }),
    );
  }

  String _getStepTitle(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).assigned;
      case 1:
        return S.of(context).pending;
      case 2:
        return S.of(context).inProgress;
      case 3:
        return S.of(context).resolved;
      default:
        return Constantmanger.mySteps[index].title;
    }
  }

  Widget _buildMapSection(LatLng apiPosition, String location) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: CustomMap.fromAPI(
        location: location,
        onmapCreated: (d, latlang) {},
        apiPosition: apiPosition,
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60.sp, color: Colors.red[300]),
          SizedBox(height: 16.h),
          Text(message),
          TextButton(
            onPressed: () => context.read<ReportCubit>().GetReportByID(
              ReportID: widget.reportId,
            ),
            child: Text(S.of(context).tryAgain),
          ),
        ],
      ),
    );
  }
}
