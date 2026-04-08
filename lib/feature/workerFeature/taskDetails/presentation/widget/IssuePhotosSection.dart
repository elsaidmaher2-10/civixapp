import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IssuePhotosSection extends StatelessWidget {
  const IssuePhotosSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ISSUE MEDIA',
          style: GoogleFonts.cairo(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ColorManger.onSurfaceVariant,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              buildPhotoCard(
                'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?q=80&w=2070',
              ),
              SizedBox(width: 12),
              buildPhotoCard(
                'https://cdn.pixabay.com/photo/2023/10/03/10/49/anonymous-8291223_1280.png',
              ),
              SizedBox(width: 12),
              buildPhotoCard(
                'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?q=80&w=2069',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildPhotoCard(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(url, width: 128, height: 128, fit: BoxFit.cover),
  );
}
