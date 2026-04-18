import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resource/colormanager.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.isvrified,
  });
  final String name;
  final bool isvrified;
  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.palette.surfaceLowest,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 64, bottom: 20),
      child: Column(
        children: [
          _Avatar(avatarUrl: avatarUrl, isvrified: isvrified),
          const SizedBox(height: 24),
          Text(
            name,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w800,
              fontSize: 30,
              color: context.palette.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl, required this.isvrified});
  final String avatarUrl;
  final bool isvrified;

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
              color: context.palette.bgLight.withOpacity(0.2),
              width: 4,
            ),
            color: context.palette.surfaceContainer,
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (isvrified)
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: context.palette.success,
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
