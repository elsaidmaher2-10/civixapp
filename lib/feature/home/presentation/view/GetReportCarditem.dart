import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCardIem extends StatelessWidget {
  final String status;
  final Color statusColor;
  final String title;
  final String location;
  final String date;
  final String ref;
  final String imageUrl;

  const ReportCardIem({
    super.key,
    required this.status,
    required this.statusColor,
    required this.title,
    required this.location,
    required this.date,
    required this.ref,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtilsManager.h16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: ScreenUtilsManager.w8,
                            height: ScreenUtilsManager.h8,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: ScreenUtilsManager.h8),
                          Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: ScreenUtilsManager.s10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtilsManager.h8),
                      Text(
                        title,
                        style: GoogleFonts.publicSans(
                          fontSize: ScreenUtilsManager.s18,
                          fontWeight: FontWeight.bold,
                          color: ColorManger.kprimary,
                        ),
                      ),
                      SizedBox(height: ScreenUtilsManager.h6),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: ScreenUtilsManager.s14,
                            color: Colors.red,
                          ),
                           SizedBox(width: ScreenUtilsManager.w4),
                          Expanded(
                            child: Text(
                              location,
                              style: GoogleFonts.publicSans(
                                fontSize: ScreenUtilsManager.s12,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtilsManager.h12),
                      Text(
                        'Submitted: $date',
                        style: TextStyle(
                          fontSize: ScreenUtilsManager.s11,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ScreenUtilsManager.w12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CupertinoActivityIndicator(
                      color: ColorManger.lightcolor,
                    ),
                    width: ScreenUtilsManager.w80,
                    height: ScreenUtilsManager.h80,
                    fit: BoxFit.fill,
                    imageUrl: imageUrl,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilsManager.w16,
              vertical: ScreenUtilsManager.h12,
            ),
            decoration: BoxDecoration(
              color: ColorManger.white,
              border: Border(
                top: BorderSide(color: Colors.black.withOpacity(0.05)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reference: $ref',
                  style: GoogleFonts.publicSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: ColorManger.lightcolor,
                  ),
                ),
                Material(
                  color: ColorManger.lightcolor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w12,
                        vertical: ScreenUtilsManager.h6,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Details',
                            style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtilsManager.s12,
                              color: ColorManger.lightcolor,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: ScreenUtilsManager.h16,
                            color: ColorManger.lightcolor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
