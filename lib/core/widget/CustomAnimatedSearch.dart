import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const CustomSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextField(
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      animationType: Animationtype.typer,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hintTexts: [
        S.of(context).searchWaterLeak,
        S.of(context).searchStreetlight,
        S.of(context).searchWaste,
        S.of(context).searchPothole,
        S.of(context).describeIssue,
      ],
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: const Color(0xff475569),
          size: ScreenUtilsManager.s20,
        ),
        isDense: true,
        fillColor: const Color(0xffF1F5F9),
        filled: true,
        hintStyle: GoogleFonts.cairo(
          color: const Color(0xff94A3B8),
          fontSize: ScreenUtilsManager.s14,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtilsManager.h10,
          horizontal: ScreenUtilsManager.w12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff475569), width: 1.5),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
    );
  }
}
