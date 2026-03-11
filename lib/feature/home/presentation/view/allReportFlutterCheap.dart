
import 'package:flutter/material.dart';

class FliterCheap extends StatelessWidget {
  const FliterCheap({super.key, required this.label, required this.isActive});
  final String label;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF003366) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: const Color(0xFF003366).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
        ],
        border: Border.all(
          color: isActive
              ? Colors.transparent
              : const Color(0xFF003366).withOpacity(0.1),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black87,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
