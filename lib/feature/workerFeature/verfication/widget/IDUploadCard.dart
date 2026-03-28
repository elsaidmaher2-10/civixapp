import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

class IDUploadCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const IDUploadCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: ColorManger.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: ColorManger.outline),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 38, color: ColorManger.workerprimary),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: ColorManger.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
