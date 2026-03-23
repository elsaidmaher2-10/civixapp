import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:citifix/feature/reports/data/Models/Report/GetReportModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Reportcard extends StatelessWidget {
  final ReportItem report;

  const Reportcard({super.key, required this.report});
  Future<bool> _showDeleteDialog(BuildContext context) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Confirm Delete'),
              content: const Text(
                'Are you sure you want to delete this report?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: ColorManger.kPrimaryDark),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),

      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),

          children: [
            SlidableAction(
              onPressed: (context) async {
                final bool shouldDelete = await _showDeleteDialog(context);
                if (shouldDelete) {
                  // TODO: Call your Cubit/API delete method here
                }
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: 108.h,
          decoration: BoxDecoration(
            color: ColorManger.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Row(
              children: [
                SizedBox(width: 11.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CupertinoActivityIndicator(
                      color: ColorManger.lightBlue,
                    ),
                    fit: BoxFit.cover,
                    height: 80.h,
                    width: 80.w,
                    imageUrl: report.imagesUrls.isNotEmpty
                        ? report.imagesUrls.first
                        : Constantmanger.defualtImage,
                  ),
                ),
                SizedBox(width: 23.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Text(
                          report.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.publicSans(
                            color: ColorManger.kPrimaryDark,
                            fontSize: ScreenUtilsManager.s16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.place_outlined, size: 12.h),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              report.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: ColorManger.lightGrey6,
                                fontSize: ScreenUtilsManager.s12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined, size: 12.h),
                          SizedBox(width: 5.w),
                          Text(
                            report.createdAt.timeAgo,
                            style: TextStyle(
                              color: ColorManger.lightGrey6,
                              fontSize: ScreenUtilsManager.s11,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: _getStatusColor(report.status).withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: _getStatusColor(report.status),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        report.status.toLowerCase(),
                        style: TextStyle(
                          color: _getStatusColor(report.status),
                          fontSize: ScreenUtilsManager.s12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xffFF7A07);
      case 'completed':
      case 'resolved':
        return Colors.green;
      default:
        return ColorManger.kPrimary;
    }
  }
}
