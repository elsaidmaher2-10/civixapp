import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/AchievementCard.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/Dotincator.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/ReportSearchBar.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/StatusBadge.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/dummydata.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportListingScreen extends StatefulWidget {
  const ReportListingScreen({super.key});

  @override
  State<ReportListingScreen> createState() => _ReportListingScreenState();
}

class _ReportListingScreenState extends State<ReportListingScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.reportsPageBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 160.h,
            automaticallyImplyLeading: false,
            leading: null,
            backgroundColor: ColorManger.reportsPageBackground,
            elevation: 4,
            pinned: true,
            title: ReportSearchBar(),
            titleSpacing: 4,
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: [
                    _buildSectionHeader('Top Achievement Reports'),
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: dummyTopReports.length,
                      options: CarouselOptions(
                        height: ScreenUtilsManager.h200,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        onPageChanged: (index, _) =>
                            setState(() => _currentIndex = index),
                      ),
                      itemBuilder: (context, index, _) =>
                          AchievementCard(report: dummyTopReports[index]),
                    ),
                    SizedBox(height: ScreenUtilsManager.h16),
                    DotIndicator(
                      itemCount: dummyTopReports.length,
                      currentIndex: _currentIndex,
                      onTap: (index) =>
                          _carouselController.animateToPage(index),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                _buildSectionHeader('Resolved Reports'),
                ...dummyResolvedReports.map((r) => ReportCard(report: r)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtilsManager.w16,
        ScreenUtilsManager.h12,
        ScreenUtilsManager.w16,
        ScreenUtilsManager.h12,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtilsManager.s18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
