import 'package:flutter/material.dart';

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
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
