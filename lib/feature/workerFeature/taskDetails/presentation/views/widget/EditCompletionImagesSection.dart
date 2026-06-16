import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/model/taskdetailsmodel.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditCompletionImagesSection extends StatelessWidget {
  final CompletionDetails completionDetails;
  final List<int> deletedImageIds;
  final Function(int id) onToggleDelete;

  const EditCompletionImagesSection({
    super.key,
    required this.completionDetails,
    required this.deletedImageIds,
    required this.onToggleDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).completionImages,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s12,
            fontWeight: FontWeight.bold,
            color: context.palette.onSurfaceVariant,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h8),
        SizedBox(
          height: ScreenUtilsManager.h80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: completionDetails.imageUrls.length,
            itemBuilder: (context, index) {
              final id = completionDetails.imageIds[index];
              final url = completionDetails.imageUrls[index];
              final isDeleted = deletedImageIds.contains(id);

              return Padding(
                padding: EdgeInsets.only(right: ScreenUtilsManager.w8),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: isDeleted ? 0.3 : 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url,
                          width: ScreenUtilsManager.w80,
                          height: ScreenUtilsManager.h80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: Icon(
                          isDeleted ? Icons.add_circle : Icons.remove_circle,
                          color: isDeleted ? Colors.green : Colors.red,
                        ),
                        onPressed: () => onToggleDelete(id),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
