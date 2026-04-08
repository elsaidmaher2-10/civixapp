import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/indicator.dart'; // تأكد من المسار
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/vedioplayer.dart'; // تأكد من المسار
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IssuePhotosSection extends StatefulWidget {
  final List<String> mediaItems; // نستقبل الروابط من الـ API

  const IssuePhotosSection({super.key, required this.mediaItems});

  @override
  State<IssuePhotosSection> createState() => _IssuePhotosSectionState();
}

class _IssuePhotosSectionState extends State<IssuePhotosSection> {
  final PageController _pageController = PageController();

  // دالة التأكد من نوع الملف (فيديو أم صورة)
  bool _isVideo(String path) {
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv'];
    return videoExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }

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
        const SizedBox(height: 12),

        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // عرض الميديا
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.mediaItems.length,
                  itemBuilder: (context, index) {
                    final String item = widget.mediaItems[index];

                    if (_isVideo(item)) {
                      return AppVideoPlayer(dataSource: item, isRemote: true);
                    }

                    return CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Image.network(
                        Constantmanger.defualtImage,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              if (widget.mediaItems.length > 1)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CustomIndicator(
                    controller: _pageController,
                    count: widget.mediaItems.length,
                    activeColor: ColorManger.kPrimary,
                    dotColor: Colors.white.withOpacity(0.7),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
