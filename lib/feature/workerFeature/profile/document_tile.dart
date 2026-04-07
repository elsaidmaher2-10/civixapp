import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum DocumentStatus { approved, pending, rejected }

extension DocumentStatusExt on DocumentStatus {
  Color get color {
    switch (this) {
      case DocumentStatus.approved:
        return ColorManager.success;
      case DocumentStatus.pending:
        return ColorManager.primaryContainer;
      case DocumentStatus.rejected:
        return ColorManager.error;
    }
  }

  IconData get icon {
    switch (this) {
      case DocumentStatus.approved:
        return Icons.check_circle;
      case DocumentStatus.pending:
        return Icons.hourglass_bottom;
      case DocumentStatus.rejected:
        return Icons.cancel;
    }
  }

  String get label {
    switch (this) {
      case DocumentStatus.approved:
        return 'APPROVED';
      case DocumentStatus.pending:
        return 'PENDING';
      case DocumentStatus.rejected:
        return 'REJECTED';
    }
  }
}

class DocumentTile extends StatelessWidget {
  const DocumentTile({
    super.key,
    required this.title,
    required this.icon,
    this.status = DocumentStatus.approved,
  });

  final String title;
  final IconData icon;
  final DocumentStatus status;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.surfaceLowest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // ── Thumbnail ──────────────────────────────────
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: ColorManager.outlineVariant, size: 32),
            ),
            const SizedBox(height: 16),
            // ── Title ──────────────────────────────────────
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ColorManager.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            // ── Status badge ───────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(status.icon, color: status.color, size: 12),
                const SizedBox(width: 4),
                Text(
                  status.label,
                  style: GoogleFonts.cairo(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: status.color,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A row of up to 3 [DocumentTile]s with gaps between them.
class DocumentsRow extends StatelessWidget {
  const DocumentsRow({super.key, required this.documents});

  final List<DocumentTileData> documents;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < documents.length; i++) ...[
          DocumentTile(
            title: documents[i].title,
            icon: documents[i].icon,
            status: documents[i].status,
          ),
          if (i < documents.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class DocumentTileData {
  const DocumentTileData({
    required this.title,
    required this.icon,
    this.status = DocumentStatus.approved,
  });

  final String title;
  final IconData icon;
  final DocumentStatus status;
}
