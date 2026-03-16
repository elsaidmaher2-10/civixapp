import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class ReportDetailsAppbar extends StatelessWidget {
  const ReportDetailsAppbar({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.5,
      pinned: true,
      stretch: true,
      backgroundColor: ColorManger.kprimary,
      leading: IconButton(
        icon: CircleAvatar(
          backgroundColor: Colors.white70,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: ColorManger.kprimary,
            size: ScreenUtilsManager.s18,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      // todo is important
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        title: Text(
          Constantmanger.reportDetails,
          style: TextStyle(
            color: ColorManger.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(blurRadius: 10, color: Colors.black45)],
          ),
        ),
        centerTitle: true,
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: image.isEmpty ? Constantmanger.defualtImage : image,
        ),
      ),
    );
  }
}
