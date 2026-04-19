import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Editfromprofile extends StatelessWidget {
  const Editfromprofile({
    required this.role,
    super.key,
    required this.EmailCotroller,
    required this.nameCotroller,
    required this.addressCotroller,
    required this.phoneCotroller,
  });

  final TextEditingController phoneCotroller;
  final TextEditingController EmailCotroller;
  final TextEditingController nameCotroller;
  final TextEditingController addressCotroller;
  final bool role;

  @override
  Widget build(BuildContext context) {
    final Color primaryThemeColor = role
        ? context.palette.workerprimary
        : context.palette.kPrimary;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFieldSection(
            context,
            label: S.of(context).fullName,
            hint: S.of(context).fullName,
            controller: nameCotroller,
            icon: Icons.person_outline,
            themeColor: primaryThemeColor,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).email,
            hint: S.of(context).hintEmail,
            controller: EmailCotroller,
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
            themeColor: primaryThemeColor,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).phone,
            hint: S.of(context).hintPhone,
            controller: phoneCotroller,
            icon: Icons.call_outlined,
            keyboardType: TextInputType.phone,
            themeColor: primaryThemeColor,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).address,
            hint: S.of(context).hintAddress,
            controller: addressCotroller,
            icon: Icons.location_on_outlined,
            themeColor: primaryThemeColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(
    BuildContext context, {
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required Color themeColor,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: ScreenUtilsManager.w4),
          child: Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h8),
        Container(
          decoration: BoxDecoration(
            color: context.palette.white,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
            boxShadow: [
              BoxShadow(
                color: themeColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: themeColor,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: themeColor.withOpacity(0.6),
                size: ScreenUtilsManager.s20,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: const Color(0xFF94A3B8),
              ),
              filled: true,
              fillColor: context.palette.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                borderSide: BorderSide(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                borderSide: BorderSide(color: themeColor, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilsManager.w16,
                vertical: ScreenUtilsManager.h16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
