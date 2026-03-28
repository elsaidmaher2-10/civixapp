import 'package:citifix/feature/citzenFeature/reports/presentation/views/AchievementImage.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/StatusBadge.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/dummydata.dart';
import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {
  final ReportModel report;
  const AchievementCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
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
        children: [
          Expanded(
            child: ReportImage(url: report.imageUrl, isTop: report.isTopImpact),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        report.address,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: report.status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
