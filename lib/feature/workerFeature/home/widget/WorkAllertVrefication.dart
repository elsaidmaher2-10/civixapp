import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

class WorkerAlertVrefication extends StatelessWidget {
  const WorkerAlertVrefication({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManger.primaryColor.withValues(alpha: 0.05),
        border: Border.all(color: ColorManger.primaryColor.withOpacity(0.1)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorManger.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.report_problem, color: ColorManger.primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification required',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorManger.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Update your ID by EOD to keep access.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF4C1F00)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
