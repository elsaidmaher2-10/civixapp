import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskFilterChips extends StatefulWidget {
  final List<String> filters;
  final List<String> filtersen;
  final Function(String) onFilterSelected;
  const TaskFilterChips({
    super.key,
    required this.filters,
    required this.onFilterSelected,
    required this.filtersen,
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
        children: List.generate(widget.filtersen.length, (index) {
          bool isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              checkmarkColor: Colors.white,
              label: Text(widget.filters[index]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => selectedIndex = index);
                widget.onFilterSelected(widget.filtersen[index]);
              },
              selectedColor: context.palette.workerprimary,
              backgroundColor: context.palette.surfaceContainerLowest,
              labelStyle: GoogleFonts.cairo(
                color: isSelected
                    ? Colors.white
                    : context.palette.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
                side: BorderSide(
                  color: isSelected
                      ? Colors.transparent
                      : context.palette.outline.withOpacity(0.15),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
