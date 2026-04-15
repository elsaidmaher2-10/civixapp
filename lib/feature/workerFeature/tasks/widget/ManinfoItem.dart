import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetaInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool muted;

  const MetaInfoItem({
    super.key,
    required this.icon,
    required this.label,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = ColorManger.onSurfaceVariant.withOpacity(muted ? 0.6 : 1.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: ScreenUtilsManager.s16, color: color),
        SizedBox(width: ScreenUtilsManager.w4),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
