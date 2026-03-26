import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportDetailsAppbar extends StatelessWidget {
  const ReportDetailsAppbar({
    super.key,
    required this.image,
    required this.ontap,
  });

  final String image;
  final Function() ontap;

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
            Directionality.of(context) == TextDirection.rtl
                ? Icons.forward
                : CupertinoIcons.back,
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
        title: Text(
          S.of(context).reportDetails,
          style: TextStyle(
            color: ColorManger.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            shadows: const [Shadow(blurRadius: 10, color: Colors.black45)],
          ),
        ),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image.isEmpty ? Constantmanger.defualtImage : image,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(color: ColorManger.kPrimary),
                ),
              ),
              errorWidget: (context, url, error) =>
                  Image.network(Constantmanger.defualtImage, fit: BoxFit.cover),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black26, Colors.transparent, Colors.black54],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
