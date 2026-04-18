import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfromfield extends StatelessWidget {
  const CustomTextfromfield({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.lable,
    this.readonly = false,
    this.initialValue,
    this.suffix,
    this.validator,
    this.obstext = false,
    this.prefix,
    this.onChanged,
    this.ktype = TextInputType.text,
    this.onTap,
    this.isworker = false,
    this.maxLines = 1,
    this.color = const Color(0xffF6F6F6),
  });

  final Function()? onTap;
  final bool readonly;
  final String hinttext;
  final Widget? suffix;
  final TextInputType ktype;
  final bool obstext;
  final bool isworker;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final String lable;
  final String? initialValue;
  final int? maxLines;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return TextFormField(
      maxLines: maxLines,
      initialValue: initialValue,
      onTap: onTap,
      readOnly: readonly,
      keyboardType: ktype,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      obscureText: obstext,
      decoration: InputDecoration(
        prefixIcon: prefix,
        labelStyle: GoogleFonts.cairo(color: scheme.onSurface, fontSize: 14.sp),
        alignLabelWithHint: true,
        labelText: lable,
        isDense: true,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        fillColor: Color(0xffF6F6F6),

        filled: true,
        suffixIcon: suffix,
        hintText: hinttext,
        hintStyle: GoogleFonts.cairo(
          color: scheme.onSurfaceVariant,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
