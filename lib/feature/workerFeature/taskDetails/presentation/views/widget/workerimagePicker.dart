import 'dart:io';
import 'package:citifix/core/function/show_full_screen_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../citzenFeature/reports/presentation/views/widget/extensionvediotype.dart';
import '../../../../../citzenFeature/reports/presentation/views/widget/vedioplayer.dart';

class ImageWorkerPickerList extends StatelessWidget {
  List<File> files;
  final void Function(int index) onRemove;

  ImageWorkerPickerList({
    super.key,
    required this.files,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          Expanded(
            child: ListView.separated(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              separatorBuilder: (_, _) => SizedBox(width: 8.w),
              itemBuilder: (ctx, index) {
                final image = files[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: SizedBox(
                    width: 100.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: image.isVideo
                                ? AppVideoPlayer(
                                  dataSource: image.path,
                                  isRemote: false,
                                  onTap:
                                      () => showFullScreenVideo(
                                        context,
                                        image.path,
                                        isRemote: false,
                                      ),
                                )
                                : Image.file(image, fit: BoxFit.cover),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            end: 4.w,
                            top: 4.h,
                            child: InkWell(
                              onTap: () => onRemove(index),
                              child: CircleAvatar(
                                radius: 12.r,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
