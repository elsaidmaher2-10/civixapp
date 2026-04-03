import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/indicator.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/vedioplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportDetailsAppbar extends StatelessWidget {
  ReportDetailsAppbar({
    super.key,
    required this.mediaItems,
    required this.ontap,
  });

  final List<String> mediaItems;
  final Function() ontap;
  final PageController pageController = PageController();

  bool _isVideo(String path) {
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv'];
    return videoExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.45,
      pinned: true,
      stretch: true,
      backgroundColor: ColorManger.kPrimary,
      leading: IconButton(
        icon: CircleAvatar(
          backgroundColor: Colors.white70,
          child: Icon(
            CupertinoIcons.back,
            color: ColorManger.kPrimary,
            size: ScreenUtilsManager.s18,
          ),
        ),
        onPressed: ontap,
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: mediaItems.length,
              itemBuilder: (BuildContext context, int index) {
                final String item = mediaItems[index];

                if (_isVideo(item)) {
                  return AppVideoPlayer(dataSource: item, isRemote: true);
                }

                return CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorManger.kPrimary,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.network(
                    Constantmanger.defualtImage,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            if (mediaItems.length > 1)
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: CustomIndicator(
                  dotSize: 8,
                  controller: pageController,
                  activeColor: ColorManger.kPrimary,
                  dotColor: Colors.white.withOpacity(0.6),
                  count: mediaItems.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
