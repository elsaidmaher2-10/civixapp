import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:citifix/core/resource/colormanager.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({super.key, required this.controller});

  final TextEditingController controller;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      locale: Localizations.localeOf(context),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManger.kPrimary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: ColorManger.kPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
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
        fillColor: Color(0xffF6F6F6),
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
