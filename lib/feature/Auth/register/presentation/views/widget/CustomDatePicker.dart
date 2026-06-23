import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({super.key, required this.controller});

  final TextEditingController controller;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      locale: Locale(Localizations.localeOf(context).languageCode),
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime(2018),
      builder: (context, child) {
        final ColorScheme baseScheme = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: baseScheme.copyWith(
              primary: context.palette.kPrimary,
              onPrimary: baseScheme.onPrimary,
              onSurface: baseScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: context.palette.kPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd', 'en').format(pickedDate);

      controller.text = formattedDate;
    }
  }

  String? _validator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return S.of(context).dateRequired;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomTextfromfield(
      controller: controller,
      hinttext: S.of(context).dateOfBirth,
      lable: S.of(context).dateOfBirth,
      readonly: true,
      onTap: () => _selectDate(context),
      validator: (value) => _validator(context, value),
      prefix: const Icon(Icons.date_range_outlined),
      fillColor: isDark
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : const Color(0xffF6F6F6),
      borderRadius: 12,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}
