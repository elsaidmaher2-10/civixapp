import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

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

      hintTexts: const [
        'Search for "Water leak"',

        'Search for "Broken streetlight"',

        'Search for "Waste accumulation"',

        'Search for "Pothole repair"',

        'Describe the issue...',
      ],

      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Color(0xff475569)),

        isDense: true,

        fillColor: const Color(0xffF1F5F9), 

        filled: true,

        hintStyle: TextStyle(
          color: const Color(0xff94A3B8),

          fontSize: ScreenUtilsManager.s14,
        ),

        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtilsManager.h10,

          horizontal: 12,
        ),

        border: OutlineInputBorder(
          borderSide: BorderSide.none,

          borderRadius: BorderRadius.circular(8),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff475569), width: 1.5),

          borderRadius: BorderRadius.circular(8),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
    );
  }
}
