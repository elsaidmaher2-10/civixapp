import 'package:citifix/feature/reports/presentation/views/dummydata.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      backgroundColor: const Color(0xFFF0F4F8),
      body: CustomScrollView(
        slivers: [
          // ── SliverAppBar with Carousel ──────────────────────────────────────
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            expandedHeight: 360,
            // Search bar stays visible when collapsed
            title: _buildSearchBar(),
            titleSpacing: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildFilterBtn(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Space for pinned search bar
                    const SizedBox(height: 96),
                    // Section title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Top Achievement Reports',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ),
                    // ── carousel_slider ──────────────────────────────────────
                    CarouselSlider.builder(
                      carouselController: _carouselController,
                      itemCount: dummyTopReports.length,
                      options: CarouselOptions(
                        height: 200,
                        viewportFraction: 0.88,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.15,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 2),
                        autoPlayAnimationDuration: const Duration(
                          milliseconds: 200,
                        ),
                        autoPlayCurve: Curves.easeInOut,
                        onPageChanged: (index, reason) {
                          setState(() => _currentIndex = index);
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return _buildAchievementCard(dummyTopReports[index]);
                      },
                    ),
                    const SizedBox(height: 10),
                    // Dot indicators
                    _buildDotIndicators(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

          // ── Resolved Reports List ───────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Resolved Reports',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF137FEC),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                ...dummyResolvedReports.map(
                  (r) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildReportCard(r),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search Reports',
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade400,
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  // ── Filter Button ───────────────────────────────────────────────────────────
  Widget _buildFilterBtn() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.tune, color: Colors.white, size: 20),
      ),
    );
  }

  // ── Achievement Card ────────────────────────────────────────────────────────
  Widget _buildAchievementCard(ReportModel report) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  report.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
                if (report.isTopImpact)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF137FEC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'TOP IMPACT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Body
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        report.address,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatusBadge(report.status),
                    const SizedBox(height: 4),
                    _buildTimeLabel(report.timeAgo),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Dot Indicators ──────────────────────────────────────────────────────────
  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dummyTopReports.length, (index) {
        final isActive = index == _currentIndex;
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 18 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF137FEC)
                  : const Color(0xFFCBD5E1),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }

  // ── Report Card ─────────────────────────────────────────────────────────────
  Widget _buildReportCard(ReportModel report) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 76,
                    height: 76,
                    child: Image.network(
                      report.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  report.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  report.address,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade300,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTimeLabel(report.timeAgo),
                          _buildStatusBadge(report.status),
                        ],
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

  // ── Helpers ─────────────────────────────────────────────────────────────────
  Widget _buildTimeLabel(String time) {
    return Row(
      children: [
        Icon(Icons.access_time, size: 12, color: Colors.grey.shade400),
        const SizedBox(width: 3),
        Text(
          time,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color textColor;
    String label;
    IconData icon;

    switch (status) {
      case 'resolved':
        bg = const Color(0xFFDCFCE7);
        textColor = const Color(0xFF166534);
        label = 'Resolved';
        icon = Icons.check_circle;
        break;
      case 'progress':
        bg = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        label = 'In Progress';
        icon = Icons.layers;
        break;
      case 'submitted':
        bg = const Color(0xFFE0E7FF);
        textColor = const Color(0xFF3730A3);
        label = 'Submitted';
        icon = Icons.radio_button_checked;
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        textColor = const Color(0xFF475569);
        label = 'Pending';
        icon = Icons.hourglass_empty;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
