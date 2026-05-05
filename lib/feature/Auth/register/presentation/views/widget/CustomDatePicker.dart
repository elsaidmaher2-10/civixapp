import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:citifix/core/resource/colormanager.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({super.key, required this.controller});

  final TextEditingController controller;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      locale: Locale(Localizations.localeOf(context).languageCode),
      context: context,
      initialDate: null,
      firstDate: DateTime(1950),
      lastDate: DateTime(2018),
      builder: (context, child) { 
       final bool isDark = Theme.of(context).brightness == Brightness.dark;
        final ColorScheme baseScheme = Theme.of(context).colorScheme;
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme.of(context),
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
    return TextFormField(
      controller: controller,
      readOnly: true,

      onTap: () => _selectDate(context),
      validator: (value) => _validator(context, value),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: context.palette.searchFieldFill,
                labelText: S.of(context).dateOfBirth,
        hintText: S.of(context).dateOfBirth,
        prefixIcon: const Icon(Icons.date_range_outlined),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
