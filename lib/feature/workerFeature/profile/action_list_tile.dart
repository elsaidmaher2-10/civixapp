import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resource/colormanager.dart';

class ActionListTile extends StatelessWidget {
  const ActionListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorManger.surfaceLowest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ColorManger.workerprimary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: ColorManger.workerprimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorManger.onSurface,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: ColorManger.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class ActionList extends StatelessWidget {
  const ActionList({super.key, required this.actions});

  final List<ActionListTileData> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          ActionListTile(
            icon: actions[i].icon,
            label: actions[i].label,
            onTap: actions[i].onTap,
          ),
          if (i < actions.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class ActionListTileData {
  const ActionListTileData({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}
