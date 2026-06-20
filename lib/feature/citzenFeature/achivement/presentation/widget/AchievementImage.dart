import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final bool isTop;

  const ReportImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.isTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          url,
          width: width,
          height: height,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.broken_image, color: Colors.grey),
          ),
        ),
        if (isTop)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF137FEC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'TOP IMPACT',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
