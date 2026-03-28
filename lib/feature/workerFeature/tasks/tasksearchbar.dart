import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManger.surfaceLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search tasks by name or location',
          hintStyle: TextStyle(
            color: ColorManger.onSurfaceVariant.withOpacity(0.6),
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF767777)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
