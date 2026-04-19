import 'package:citifix/core/cubit/LogOut/LogOutcubit.dart';
import 'package:citifix/core/resource/citifix_palette.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> onLogoutPressed(BuildContext context) async {
  final confirmed = await LogoutConfirmDialog.show(context);
  if (confirmed == true && context.mounted) {
    context.read<LogCubit>().logout();
  }
}

class LogoutConfirmDialog extends StatelessWidget {
  const LogoutConfirmDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LogoutConfirmDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Column(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtilsManager.h16),
            decoration: BoxDecoration(
              color: context.palette.redLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout_rounded,
              color: context.palette.red,
              size: ScreenUtilsManager.s32,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          Text(
            S.of(context).logout,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      content: Text(
        S.of(context).logoutConfirmationMessage,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s14,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.palette.kPrimary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                ),
                child: Text(
                  S.of(context).cancel,
                  style: GoogleFonts.cairo(
                    color: context.palette.kPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: ScreenUtilsManager.w12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.palette.red,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtilsManager.h12,
                  ),
                ),
                child: Text(
                  S.of(context).logout,
                  style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
