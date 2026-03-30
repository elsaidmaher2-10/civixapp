import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

class TaskFilterChips extends StatefulWidget {
  final List<String> filters;
  final Function(String) onFilterSelected;
  const TaskFilterChips({super.key, 
    required this.filters,
    required this.onFilterSelected,
  });

  @override
  State<TaskFilterChips> createState() => _TaskFilterChipsState();
}

class _TaskFilterChipsState extends State<TaskFilterChips> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.filters.length, (index) {
          bool isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              checkmarkColor: ColorManger.white,
              label: Text(widget.filters[index]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => selectedIndex = index);
                widget.onFilterSelected(widget.filters[index]);
              },
              selectedColor: ColorManger.primaryColor,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? Colors.white : Colors.grey.shade200,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
