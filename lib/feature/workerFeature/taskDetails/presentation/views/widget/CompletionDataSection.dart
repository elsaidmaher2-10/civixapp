import 'dart:async';
import 'dart:io';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/showmodalbottomsheetimage.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/workerimagePicker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/resource/colormanager.dart';

class CompletionDataSection extends StatefulWidget {
  const CompletionDataSection({
    super.key,
    required this.onFilesChanged,
    required this.streamController,
    required this.notesController,
    required this.addimage,
    required this.removeImage,
  });

  final StreamController<List<File>> streamController;
  final Function(List<File>) onFilesChanged;
  final TextEditingController notesController;
  final Function(int index) removeImage;
  final Function(List<File>) addimage;

  @override
  State<CompletionDataSection> createState() => CompletionDataSectionState();
}

class CompletionDataSectionState extends State<CompletionDataSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: ColorManger.workerprimary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'COMPLETION DATA',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'PROOF OF WORK *',
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          StreamBuilder<List<File>>(
            stream: widget.streamController.stream,
            builder:
                (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
                  final bool hasImages =
                      snapshot.data != null && snapshot.data!.isNotEmpty;
                  if (hasImages) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            final images = await showImageBottomSheet(context);
                            if (images != null && images.isNotEmpty) {
                              widget.addimage(images);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: DottedBorder(
                            child: Container(
                              height: 105.h,
                              width: 80.w,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 28,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Add",
                                    style: GoogleFonts.cairo(
                                      color: Colors.grey.shade700,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ImageWorkerPickerList(
                            files: snapshot.data!,
                            onRemove: (int index) {
                              widget.removeImage(index);
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        final images = await showImageBottomSheet(context);
                        if (images != null && images.isNotEmpty) {
                          widget.addimage(images);
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: DottedBorder(
                        child: Container(
                          height: 120.h,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 28,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Upload Completion Images",
                                style: GoogleFonts.cairo(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
          ),
          const SizedBox(height: 24),

          Text(
            'COMPLETION NOTES',
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          CustomTextfromfield(
            controller: widget.notesController,
            hinttext: "add Notes",
            lable: "Notes",
          ),
        ],
      ),
    );
  }
}

class MarkAsCompletedButton extends StatelessWidget {
  const MarkAsCompletedButton({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });

  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF8A00),
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: const Color(0xFFFF8A00).withOpacity(0.4),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.5,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.verified, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Mark as Completed',
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
    );
  }
}
