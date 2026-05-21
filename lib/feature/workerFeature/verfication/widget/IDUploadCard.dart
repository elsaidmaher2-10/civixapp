import 'dart:async';
import 'dart:io';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IDUploadCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback ontap;
  final VoidCallback removeimagebtn;
  final StreamController<File?> imageController;

  const IDUploadCard({
    required this.ontap,
    required this.imageController,
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.removeimagebtn,
  });

  @override
  Widget build(BuildContext context) {
    const double cardRadius = 28.0;

    return StreamBuilder<File?>(
      stream: imageController.stream,
      builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
        final bool hasImage = snapshot.hasData && snapshot.data != null;

        return InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(cardRadius),
          child: Container(
            height: ScreenUtilsManager.h180,
            decoration: BoxDecoration(
              color: context.palette.surface,
              borderRadius: BorderRadius.circular(cardRadius),
              border: Border.all(color: context.palette.outline.withOpacity(0.5)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cardRadius - 1),
              child: hasImage
                  ? Stack(
                      children: [
                        Positioned.fill(
                          child: Image.file(snapshot.data!, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: ScreenUtilsManager.h4,
                          right: ScreenUtilsManager.w4,
                          child: GestureDetector(
                            onTap: removeimagebtn,
                            child: Padding(
                              padding: EdgeInsets.all(ScreenUtilsManager.w8),
                              child: CircleAvatar(
                                radius: ScreenUtilsManager.r12,
                                backgroundColor: context.palette.workerprimary
                                    .withOpacity(0.8),
                                child: Icon(
                                  Icons.close,
                                  size: ScreenUtilsManager.s20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: ScreenUtilsManager.s40, color: context.palette.workerprimary),
                        SizedBox(height: ScreenUtilsManager.h12),
                        Text(
                          title,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtilsManager.s14,
                            color: context.palette.onSurface,
                          ),
                        ),
                        SizedBox(height: ScreenUtilsManager.h4),
                        Text(
                          subtitle,
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s11,
                            color: context.palette.onSurfaceVariant.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
