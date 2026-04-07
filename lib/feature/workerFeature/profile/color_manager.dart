import 'package:flutter/material.dart';

class ColorManager {
  // ─── Surfaces ───────────────────────────────────────────
  static const Color background              = Color(0xFFF6F6F6);
  static const Color surfaceLowest           = Color(0xFFFFFFFF);
  static const Color surfaceContainer        = Color(0xFFE7E8E8);
  static const Color surfaceContainerLow     = Color(0xFFF0F1F1);
  static const Color surfaceContainerHighest = Color(0xFFDBDDDD);

  // ─── Brand ──────────────────────────────────────────────
  static const Color primary          = Color(0xFF954400);
  static const Color primaryContainer = Color(0xFFFF7B04);

  // ─── Text / Icons ────────────────────────────────────────
  static const Color onSurface        = Color(0xFF2D2F2F);
  static const Color onSurfaceVariant = Color(0xFF5A5C5C);
  static const Color outlineVariant   = Color(0xFFACADAD);

  // ─── Semantic ────────────────────────────────────────────
  static const Color error   = Color(0xFFB02500);
  static const Color success = Color(0xFF4CAF50);

  // ─── Gradients ───────────────────────────────────────────
  static const LinearGradient kineticGradient = LinearGradient(
    colors: [primary, primaryContainer],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
