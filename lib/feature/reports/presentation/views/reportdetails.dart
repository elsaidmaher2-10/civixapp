import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/reports/presentation/views/widget/CustomTimelineTile.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:citifix/feature/reports/presentation/views/widget/ReportDetailsAppbar.dart';
import 'package:citifix/feature/reports/presentation/views/widget/ReportdetailsBadge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class ReportDetailsScreen extends StatefulWidget {
  final ReportResponseModel reportResponseModel;

  ReportDetailsScreen({required this.reportResponseModel, super.key});

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ReportDetailsAppbar(
            image: widget.reportResponseModel.imagesUrls.isNotEmpty
                ? widget.reportResponseModel.imagesUrls.first
                : Constantmanger.defualtImage,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildStatusBadge(widget.reportResponseModel.status),
                  SizedBox(height: 12.h),
                  Text(
                    widget.reportResponseModel.title,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: ColorManger.kPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  Text(
                    widget.reportResponseModel.description,

                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorManger.kPrimary.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    "Location",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.kPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  _buildMapSection(
                    LatLng(
                      widget.reportResponseModel.latitude,
                      widget.reportResponseModel.longitude,
                    ),
                    widget.reportResponseModel.location,
                  ),
                  SizedBox(height: 24.h),

                  Text(
                    "Timeline",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.kPrimary,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(Constantmanger.mySteps.length, (
                      index,
                    ) {
                      int curindex = StatusReport.fromString("Active").index;
                      return CustomTimelineTile(
                        title: Constantmanger.mySteps[index].title,
                        isFirst: index == 0,
                        isDone: curindex >= index,
                        isLast: index == Constantmanger.mySteps.length - 1,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
}
