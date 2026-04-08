import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:citifix/feature/workerFeature/taskDetails/data/model/taskdetailsmodel.dart';

class TaskOwnerHeader extends StatelessWidget {
  final TaskDetailsModel task;

  const TaskOwnerHeader({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: task.citizenProfileImageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade200,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.citizenName ?? "Unknown",
                    style: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),

                  Text(
                    '• Task Owner',
                    style: GoogleFonts.cairo(
                      color: ColorManger.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 📅 DATE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'CREATED',
                style: GoogleFonts.cairo(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 2),

              Text(
                _formatDate(task.createdAt),
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🧠 simple date formatter
  String _formatDate(String? date) {
    if (date == null) return "Unknown";

    try {
      final dt = DateTime.parse(date);
      final diff = DateTime.now().difference(dt);

      if (diff.inMinutes < 60) {
        return "${diff.inMinutes} min ago";
      } else if (diff.inHours < 24) {
        return "${diff.inHours} hours ago";
      } else {
        return "${diff.inDays} days ago";
      }
    } catch (e) {
      return date;
    }
  }
}
