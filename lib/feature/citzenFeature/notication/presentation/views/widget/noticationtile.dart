import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
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
    final bool isWorker =
        PrefrenceManager().getstring("role")?.toLowerCase() == "worker";
    final Color primaryColor = isWorker
        ? context.palette.workerprimary
        : context.palette.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r15),
        onTap: onTap,
        highlightColor: primaryColor.withOpacity(0.05),
        splashColor: primaryColor.withOpacity(0.1),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(ScreenUtilsManager.w16),
          decoration: BoxDecoration(
            color: item.isRead
                ? Theme.of(context).scaffoldBackgroundColor
                : primaryColor.withOpacity(0.03),
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r15),
            border: Border.all(
              color: item.isRead
                  ? Colors.grey.shade200
                  : primaryColor.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: item.isRead
                ? []
                : [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconContainer(primaryColor),

              SizedBox(width: ScreenUtilsManager.w12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s16,
                        fontWeight: item.isRead
                            ? FontWeight.w600
                            : FontWeight.w800,
                        color: item.isRead ? Colors.black87 : Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ScreenUtilsManager.h4),
                    Text(
                      item.message,
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s14,
                        color: item.isRead
                            ? Colors.grey.shade500
                            : Colors.grey.shade800,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: ScreenUtilsManager.w8),

              _buildDeleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(Color primaryColor) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w10),
          decoration: BoxDecoration(
            color: item.isRead
                ? Colors.grey.shade100
                : primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            item.isRead
                ? Icons.notifications_none_rounded
                : Icons.notifications_active_rounded,
            color: item.isRead ? Colors.grey.shade400 : primaryColor,
            size: ScreenUtilsManager.s20,
          ),
        ),
        if (!item.isRead)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              width: ScreenUtilsManager.w12,
              height: ScreenUtilsManager.h12,
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
        child: Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w8),
          decoration: BoxDecoration(
            color: Colors.red.shade50.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close_rounded,
            color: Colors.red.shade400,
            size: ScreenUtilsManager.s18,
          ),
        ),
      ),
    );
  }
}
