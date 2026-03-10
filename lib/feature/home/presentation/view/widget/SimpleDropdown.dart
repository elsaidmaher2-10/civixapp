import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);
  final List<String> items;
  final Function(dynamic value) onChanged;
  final SingleSelectController controller;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<dynamic>.search(
      validateOnChange: true,
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return 'Please select a category';
        }
        return null;
      },
      controller: controller,
      hintText: 'Select Category',
      items: items,
      onChanged: onChanged,
    );
  }
}
