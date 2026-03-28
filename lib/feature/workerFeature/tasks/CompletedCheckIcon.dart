import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../verfication/verficationinit.dart';

class CompletedCheckIcon extends StatelessWidget {
  const CompletedCheckIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.check_circle, color: Colors.green, size: 28),
    );
  }
}
