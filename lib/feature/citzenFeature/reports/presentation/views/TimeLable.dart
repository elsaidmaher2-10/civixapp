import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeLabel extends StatelessWidget {
  final String time;
  const TimeLabel({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.access_time, size: 12, color: Colors.grey.shade400),
        const SizedBox(width: 3),
        Text(
          time,
          style: GoogleFonts.cairo(
            fontSize: 10,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
