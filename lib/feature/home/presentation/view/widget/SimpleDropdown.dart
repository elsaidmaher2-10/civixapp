import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';

class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({Key? key, required this.items, required this.onChanged})
    : super(key: key);
  final List<String> items;
  final Function(dynamic value) onChanged;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>.search(
      hintText: 'Select Category',
      items: items,
      initialItem: items[0],
      onChanged: onChanged,
    );
  }
}
