import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/cupertino.dart';

Widget buildWorkerCard({required String label, required String value}) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorManger.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorManger.onSurface.withOpacity(0.04),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: ColorManger.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
