import 'dart:async';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../verfication/verficationinit.dart';

class TaskFilterChips extends StatefulWidget {
  final List<String> filters;
  final Function(String selecteFilter) filter;
  const TaskFilterChips({
    super.key,
    required this.filters,
    required this.filter,
  });

  @override
  State<TaskFilterChips> createState() => _TaskFilterChipsState();
}

class _TaskFilterChipsState extends State<TaskFilterChips> {
  late final StreamController<int> _selectedIndexController;

  @override
  void initState() {
    super.initState();

    _selectedIndexController = StreamController<int>.broadcast();
    _selectedIndexController.add(0);
  }

  @override
  void dispose() {
    _selectedIndexController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: List.generate(
          widget.filters.length,
          (index) => _FilterChip(
            label: widget.filters[index],
            index: index,
            selectedIndexStream: _selectedIndexController.stream,
            onTap: () {
              widget.filter(widget.filters[index]);
              _selectedIndexController.add(index);
            },
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int index;
  final Stream<int> selectedIndexStream;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.index,
    required this.selectedIndexStream,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: selectedIndexStream,
      builder: (context, snapshot) {
        final bool isSelected = snapshot.data == index;
        return Container(
          margin: const EdgeInsets.only(right: 12),
          child: Material(
            color: isSelected
                ? ColorManger.primaryFixed
                : ColorManger.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            shadowColor: isSelected
                ? ColorManger.primaryFixed.withOpacity(0.4)
                : Colors.transparent,
            elevation: isSelected ? 4 : 0,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: isSelected
                        ? Colors.white
                        : ColorManger.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
