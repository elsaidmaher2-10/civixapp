import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/workerFeature/tasks/data/model/ReportResponse.dart';
import 'package:flutter/material.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';

import '../../../../core/widget/stautsBageApp.dart';

class ActiveTaskCard extends StatelessWidget {
  final ReportModelWorker task;

  const ActiveTaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilsManager.h16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.imagesUrls.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenUtilsManager.r16),
              ),
              child: Image.network(
                task.imagesUrls.first,
                height: ScreenUtilsManager.h150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(ScreenUtilsManager.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusBadgeApp(status: task.status),
                    Text(
                      "#${task.hashCode}",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtilsManager.h12),
                Text(
                  task.title ?? "No Title",
                  style: TextStyle(
                    fontSize: ScreenUtilsManager.s18,
                    fontWeight: FontWeight.w800,
                    color: ColorManger.onSurface,
                    fontFamily: 'Manrope',
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h6),
                _LocationRow(address: "Unknown Location"),
              ],
            ),
          ),

          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.all(ScreenUtilsManager.w16),
            child: TaskStatus.fromString(task.status) == TaskStatus.inProgress
                ? const _InProgressActions()
                : const _AvailableActions(),
          ),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final String address;
  const _LocationRow({required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_rounded,
          size: 14,
          color: ColorManger.primaryColor,
        ),
        SizedBox(width: ScreenUtilsManager.w4),
        Expanded(
          child: Text(
            address,
            style: TextStyle(
              fontSize: ScreenUtilsManager.s13,
              color: Colors.grey.shade600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  final TaskStatus status;
  const StatusBadge({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    Color color = status == TaskStatus.assigned
        ? Colors.orange
        : ColorManger.primaryColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AvailableActions extends StatelessWidget {
  const _AvailableActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.red.shade200),
              foregroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
              ),
            ),
            child: const Text(
              'Decline',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Manrope',
              ),
            ),
          ),
        ),

        SizedBox(width: ScreenUtilsManager.w12),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManger.workerprimary,
                  ColorManger.workerprimary.withAlpha(200),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
              boxShadow: [
                BoxShadow(
                  color: ColorManger.workerprimary.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                ),
              ),
              child: const Text(
                'Accept Task',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Manrope',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InProgressActions extends StatelessWidget {
  const _InProgressActions();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManger.onSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'View Directions & Update',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
