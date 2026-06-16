import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/function/show_full_screen_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/indicator.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/model/taskdetailsmodel.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerCompletionDetailsSection extends StatefulWidget {
  final CompletionDetails completionDetails;
  final String status;
  final VoidCallback onEdit;

  const WorkerCompletionDetailsSection({
    super.key,
    required this.completionDetails,
    required this.status,
    required this.onEdit,
  });

  @override
  State<WorkerCompletionDetailsSection> createState() =>
      _WorkerCompletionDetailsSectionState();
}

class _WorkerCompletionDetailsSectionState
    extends State<WorkerCompletionDetailsSection> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).completionDetails,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                fontWeight: FontWeight.bold,
                color: context.palette.onSurface,
              ),
            ),
            if (widget.status.toLowerCase() != 'resolved' &&
                widget.status.toLowerCase() != 'completed')
              TextButton.icon(
                onPressed: widget.onEdit,
                icon: Icon(
                  Icons.edit_note_rounded,
                  size: ScreenUtilsManager.s20,
                  color: context.palette.workerprimary,
                ),
                label: Text(
                  S.of(context).editProfile.split(' ').first, // Just "Edit"
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s12,
                    fontWeight: FontWeight.bold,
                    color: context.palette.workerprimary,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: ScreenUtilsManager.h12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(ScreenUtilsManager.w16),
          decoration: BoxDecoration(
            color: context.palette.surface,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            boxShadow: [
              BoxShadow(
                color: context.palette.black.withOpacity(0.05),
                blurRadius: ScreenUtilsManager.s10,
                offset: Offset(0, ScreenUtilsManager.h5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.completionDetails.note.isNotEmpty) ...[
                Text(
                  S.of(context).completionNote,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s12,
                    fontWeight: FontWeight.bold,
                    color: context.palette.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h4),
                Text(
                  widget.completionDetails.note,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    color: context.palette.onSurface,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h16),
              ],
              if (widget.completionDetails.imageUrls.isNotEmpty) ...[
                Text(
                  S.of(context).completionImages,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s12,
                    fontWeight: FontWeight.bold,
                    color: context.palette.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h12),
                Container(
                  height: ScreenUtilsManager.h200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ScreenUtilsManager.r12),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.completionDetails.imageUrls.length,
                          itemBuilder: (context, index) {
                            final String url =
                                widget.completionDetails.imageUrls[index];
                            return InkWell(
                              onTap: () => showFullScreenImage(context, url),
                              child: CachedNetworkImage(
                                imageUrl: url,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => Container(
                                      color: context.palette.grey200,
                                      child: Center(
                                        child: CupertinoActivityIndicator(
                                          radius: ScreenUtilsManager.r12,
                                          color: context.palette.primaryColor,
                                        ),
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Image.network(
                                      Constantmanger.defualtImage,
                                      fit: BoxFit.cover,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (widget.completionDetails.imageUrls.length > 1)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: ScreenUtilsManager.h12,
                          ),
                          child: CustomIndicator(
                            controller: _pageController,
                            count: widget.completionDetails.imageUrls.length,
                            activeColor: context.palette.kPrimary,
                            dotColor: context.palette.white.withOpacity(0.7),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
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
