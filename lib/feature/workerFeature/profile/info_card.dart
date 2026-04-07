import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ColorManager.surfaceLowest,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────
          Row(
            children: [
              Icon(icon, color: ColorManager.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: ColorManager.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // ── Body ────────────────────────────────────────────
          ...children,
        ],
      ),
    );
  }
}

/// A labeled field row used inside [InfoCard].
class InfoField extends StatelessWidget {
  const InfoField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: ColorManager.onSurfaceVariant,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorManager.onSurface,
          ),
        ),
      ],
    );
  }
}

/// Highlighted vehicle chip used inside the Vehicle card.
class VehicleChip extends StatelessWidget {
  const VehicleChip({
    super.key,
    required this.label,
    required this.vehicleName,
    required this.details,
  });

  final String label;
  final String vehicleName;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: ColorManager.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            vehicleName,
            style: GoogleFonts.cairo(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            details,
            style: GoogleFonts.cairo(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorManager.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// A simple icon + text row (e.g. insurance note).
class IconTextRow extends StatelessWidget {
  const IconTextRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ColorManager.onSurfaceVariant),
        const SizedBox(width: 16),
        Text(
          text,
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: ColorManager.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
