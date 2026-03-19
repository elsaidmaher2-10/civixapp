import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chanagepassword extends StatelessWidget {
  const Chanagepassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.confirmPassword,
          arguments: {"screen": "profile"},
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManger.kPrimary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: ColorManger.kPrimary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  'Change Password',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorManger.kPrimary,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: ColorManger.kPrimary,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
