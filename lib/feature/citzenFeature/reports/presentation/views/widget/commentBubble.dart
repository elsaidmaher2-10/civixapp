import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/extenstion/datetimeextension.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/commentmodel/commentmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../generated/l10n.dart';

class CommentBubble extends StatelessWidget {
  final CommentModel comment;
  const CommentBubble({super.key, required this.comment});
  @override
  Widget build(BuildContext context) {
    bool isWorker = comment.userRole == UserType.worker;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: isWorker
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isWorker
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (isWorker) _buildTime(context),
              SizedBox(width: 8.w),
              Text(
                isWorker ? S.of(context).worker : S.of(context).reporter,
                style: GoogleFonts.cairo(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: isWorker
                      ? ColorManger.workerprimary
                      : ColorManger.primary,
                ),
              ),
              SizedBox(width: 8.w),
              if (!isWorker) _buildTime(context),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: isWorker
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isWorker)
                _buildAvatar(comment.userProfileImageUrl, Colors.red),
              SizedBox(width: 8.w),
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: isWorker
                        ? ColorManger.workerprimary
                        : ColorManger.primary,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        color: Colors.black12,
                      ),
                    ],
                    borderRadius: BorderRadiusGeometry.directional(
                      topStart: Radius.circular(12.r),
                      topEnd: Radius.circular(12.r),
                      bottomStart: isWorker
                          ? Radius.circular(12.r)
                          : Radius.zero,
                      bottomEnd: isWorker ? Radius.zero : Radius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    comment.commentText,
                    style: GoogleFonts.cairo(
                      fontSize: 13.sp,
                      color: isWorker ? Colors.white : Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (isWorker)
                _buildAvatar(
                  comment.userProfileImageUrl,
                  ColorManger.workerprimary,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTime(BuildContext context) {
    return Text(
      comment.createdAt.timeAgo(context),
      style: GoogleFonts.cairo(fontSize: 10.sp, color: const Color(0xff737783)),
    );
  }

  Widget _buildAvatar(String url, Color color) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: color.withOpacity(0.1),
      child: ClipOval(
        child: CachedNetworkImage(
          placeholder: (context, url) =>
              const CupertinoActivityIndicator(radius: 8),
          errorWidget: (c, e, s) => Icon(Icons.person, size: 18, color: color),
          imageUrl: url,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
