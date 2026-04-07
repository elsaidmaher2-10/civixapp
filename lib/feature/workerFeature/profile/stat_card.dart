import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../managers/color_manager.dart';

/// A single stat card. Pass [useGradient] = true for the highlighted variant.
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.useGradient = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool useGradient;

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        useGradient ? Colors.black : ColorManager.primaryContainer;
    final Color valueColor =
        useGradient ? Colors.white : ColorManager.onSurface;
    final Color labelColor =
        useGradient ? Colors.white.withOpacity(0.8) : ColorManager.onSurfaceVariant;

    return Container(
      width: 176,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: useGradient ? null : ColorManager.surfaceLowest,
        gradient: useGradient ? ColorManager.kineticGradient : null,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (useGradient ? ColorManager.primary : ColorManager.onSurface)
                .withOpacity(useGradient ? 0.15 : 0.04),
            blurRadius: 32,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w800,
              fontSize: 24,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: labelColor,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Horizontal scrolling row of [StatCard]s.
class StatsScrollRow extends StatelessWidget {
  const StatsScrollRow({super.key, required this.stats});

  final List<StatCardData> stats;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      clipBehavior: Clip.none,
      child: Row(
        children: [
          for (int i = 0; i < stats.length; i++) ...[
            StatCard(
              icon: stats[i].icon,
              value: stats[i].value,
              label: stats[i].label,
              useGradient: stats[i].useGradient,
            ),
            if (i < stats.length - 1) const SizedBox(width: 16),
          ],
        ],
      ),
    );
  }
}

/// Data model for a stat card.
class StatCardData {
  const StatCardData({
    required this.icon,
    required this.value,
    required this.label,
    this.useGradient = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool useGradient;
}
