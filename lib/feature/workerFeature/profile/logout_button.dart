import 'package:citifix/feature/workerFeature/profile/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        side: BorderSide(color: ColorManager.error.withOpacity(0.2), width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        foregroundColor: ColorManager.error,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.logout, size: 24),
          const SizedBox(width: 8),
          Text(
            'Logout Account',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
