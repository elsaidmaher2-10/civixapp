import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/achievement/achicvementState.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/achievement/achivementManger.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/AchievementCard.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/Dotincator.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/ReportSearchBar.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/achievementItem.dart';
import '../../../../../generated/l10n.dart';

class AchievemrntReportScreen extends StatefulWidget {
  const AchievemrntReportScreen({super.key});

  @override
  State<AchievemrntReportScreen> createState() =>
      _AchievemrntReportScreenState();
}

class _AchievemrntReportScreenState extends State<AchievemrntReportScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<AchievementCubit>().getAchievements();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isFetchingMore) return;
    setState(() => _isFetchingMore = true);
    await context.read<AchievementCubit>().getAchievements();
    if (mounted) setState(() => _isFetchingMore = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      backgroundColor: ColorManger.reportsPageBackground,
      body: BlocBuilder<AchievementCubit, AchievementState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                pinned: true,
                backgroundColor: ColorManger.reportsPageBackground,
                elevation: 0,
                toolbarHeight: 10,
                automaticallyImplyLeading: false,
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: const ReportSearchBar(),
                ),
              ),

              if (state is AchievementLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CupertinoActivityIndicator(radius: 15)),
                )
              else if (state is AchievementError)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildErrorWidget(l10n, state.message),
                )
              else if (state is AchievementSuccess)
                ..._buildSuccessContent(l10n, state)
              else
                const SliverToBoxAdapter(child: SizedBox()),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildSuccessContent(S l10n, AchievementSuccess state) {
    final reports = state.reports;

    if (reports.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(l10n.noData, style: GoogleFonts.cairo(fontSize: 16.sp)),
          ),
        ),
      ];
    }

    final topReports = reports.take(5).toList();

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(l10n.topAchievements),
              SizedBox(height: 12.h),
              if (topReports.isNotEmpty) ...[
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: topReports.length,
                  options: CarouselOptions(
                    height: ScreenUtilsManager.h200,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    onPageChanged: (index, _) =>
                        setState(() => _currentIndex = index),
                  ),
                  itemBuilder: (context, index, _) =>
                      AchievementCard(report: topReports[index]),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: DotIndicator(
                    itemCount: topReports.length,
                    currentIndex: _currentIndex,
                    onTap: (index) => _carouselController.animateToPage(index),
                  ),
                ),
              ],
              SizedBox(height: 24.h),
              _sectionTitle(l10n.resolvedReports),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),

      SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == reports.length) {
              return state.hasMore
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: const CupertinoActivityIndicator(),
                    )
                  : SizedBox(height: 40.h);
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: AchievementReportCard(report: reports[index]),
            );
          }, childCount: reports.length + 1),
        ),
      ),
    ];
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        fontSize: ScreenUtilsManager.s18,
        fontWeight: FontWeight.w800,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildErrorWidget(S l10n, String message) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, size: 64.w, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            l10n.errorOccurred,
            style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<AchievementCubit>().getAchievements(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManger.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
