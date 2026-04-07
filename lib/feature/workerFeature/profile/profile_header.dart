import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../managers/color_manager.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.avatarUrl,
  });

  final String name;
  final double rating;
  final int reviewCount;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorManager.surfaceLowest,
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 64,
        bottom: 40,
      ),
      child: Column(
        children: [
          _Avatar(avatarUrl: avatarUrl),
          const SizedBox(height: 24),
          Text(
            name,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w800,
              fontSize: 30,
              color: ColorManager.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          _RatingRow(rating: rating, reviewCount: reviewCount),
        ],
      ),
    );
  }
}

// ─── Private sub-widgets ────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl});
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorManager.primaryContainer.withOpacity(0.2),
              width: 4,
            ),
            color: ColorManager.surfaceContainer,
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: ColorManager.success,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }
}

class _RatingRow extends StatelessWidget {
  const _RatingRow({required this.rating, required this.reviewCount});
  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: ColorManager.primaryContainer, size: 20),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: ColorManager.primary,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '($reviewCount reviews)',
          style: GoogleFonts.cairo(
            color: ColorManager.onSurfaceVariant,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
