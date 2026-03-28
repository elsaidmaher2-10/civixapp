import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
class StepHeader extends StatelessWidget {
  final String title;
  final String stepLabel;

  const StepHeader({super.key, required this.title, required this.stepLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorManger.onSurface,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: ColorManger.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorManger.outline),
          ),
          child: Text(
            stepLabel.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: ColorManger.secondary,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}
