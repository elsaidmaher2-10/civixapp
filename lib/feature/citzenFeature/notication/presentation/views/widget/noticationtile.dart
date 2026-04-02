import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/citzenFeature/notication/data/model/notifavtionmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationTile extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          highlightColor: ColorManger.primary.withOpacity(0.05),
          splashColor: ColorManger.primary.withOpacity(0.1),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item.isRead
                  ? Theme.of(context).scaffoldBackgroundColor
                  : ColorManger.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: item.isRead
                    ? Colors.grey.shade200
                    : ColorManger.primary.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: item.isRead
                  ? []
                  : [
                      BoxShadow(
                        color: ColorManger.primary.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIconContainer(),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: item.isRead
                              ? FontWeight.w600
                              : FontWeight.bold,
                          color: item.isRead ? Colors.black87 : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.message,
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          color: item.isRead
                              ? Colors.grey.shade600
                              : Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                _buildDeleteButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: item.isRead
                ? Colors.grey.shade100
                : ColorManger.primaryFixed,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_rounded,
            color: item.isRead ? Colors.grey.shade500 : ColorManger.primary,
            size: 24,
          ),
        ),
        if (!item.isRead)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onDelete,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete_outline_rounded,
            color: Colors.red.shade300,
            size: 22,
          ),
        ),
      ),
    );
  }
}
