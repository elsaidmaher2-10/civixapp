import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Editfromprofile extends StatelessWidget {
  Editfromprofile({
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
  bool role;
  @override
  Widget build(BuildContext context) {
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
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).email,
            hint: S.of(context).hintEmail,
            controller: EmailCotroller,
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).phone,
            hint: S.of(context).hintPhone,
            controller: phoneCotroller,
            icon: Icons.call_outlined,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: ScreenUtilsManager.h20),
          _buildTextFieldSection(
            context,
            label: S.of(context).address,
            hint: S.of(context).hintAddress,
            controller: addressCotroller,
            icon: Icons.location_on_outlined,
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h8),
        Container(
          decoration: BoxDecoration(
            color: context.palette.white,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF94A3B8),
                size: ScreenUtilsManager.s20,
              ),
              hintText: hint,
              hintStyle: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s14,
                color: const Color(0xFF94A3B8),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
                borderSide: BorderSide(
                  // ignore: unrelated_type_equality_checks
                  color: role
                      ? context.palette.errorContainer
                      : context.palette.kPrimary,
                  width: 2,
                ),
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
