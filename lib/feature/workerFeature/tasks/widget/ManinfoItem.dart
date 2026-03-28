import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/cupertino.dart';


class MetaInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool muted;

  const MetaInfoItem({
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
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
