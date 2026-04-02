import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for tasks...',
          hintStyle: GoogleFonts.cairo(
            color: Colors.grey.shade400,
            fontSize: ScreenUtilsManager.s14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: ColorManger.primaryColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: ScreenUtilsManager.h16,
          ),
        ),
      ),
    );
  }
}
