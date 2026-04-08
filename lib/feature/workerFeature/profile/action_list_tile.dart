import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          color: ColorManager.surfaceLowest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: ColorManager.primaryContainer.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: ColorManager.primaryContainer),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.onSurface,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: ColorManager.outlineVariant),
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
