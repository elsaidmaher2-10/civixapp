import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:flutter/material.dart';

/// Light / dark [ThemeData] derived from [ColorManger] brand colors.
abstract final class AppTheme {
  static Color _accentForRole(AppRole role) =>
      role == AppRole.worker ? ColorManger.workerprimary : ColorManger.kPrimary;

  static ThemeData light(AppRole role) {
    final Color accent = _accentForRole(role);
    final ColorScheme scheme = ColorScheme.light(
      primary: ColorManger.kPrimary,
      onPrimary: ColorManger.onPrimary,
      primaryContainer: ColorManger.primaryFixed,
      onPrimaryContainer: ColorManger.primary,
      secondary: ColorManger.lightGrey6,
      onSecondary: ColorManger.white,
      surface: ColorManger.surfaceLowest,
      onSurface: ColorManger.onSurface,
      onSurfaceVariant: ColorManger.onSurfaceVariant,
      error: ColorManger.error,
      onError: ColorManger.white,
      outline: ColorManger.outline,
      surfaceContainerHighest: ColorManger.surfaceContainer,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      extensions: <ThemeExtension<dynamic>>[CitifixPalette.light()],
      colorScheme: scheme,
      scaffoldBackgroundColor: ColorManger.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: DividerThemeData(
        color: ColorManger.border.withValues(alpha: 0.6),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManger.kPrimary,
          foregroundColor: ColorManger.white,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: accent,
        selectionColor: accent.withValues(alpha: 0.35),
        cursorColor: ColorManger.kPrimary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorManger.searchFieldFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManger.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ColorManger.outline),
        ),
      ),
    );
  }

  /// Dark surfaces from navy [ColorManger.kPrimaryDark] / [ColorManger.primary],
  /// with a lighter primary for contrast on dark backgrounds.
  static ThemeData dark(AppRole role) {
    final Color accent = _accentForRole(role);
    const Color surface = Color(0xFF1B2634);
    const Color surfaceHigh = Color(0xFF273549);
    const Color onSurfaceMain = Color(0xFFF1F5F9);
    const Color onSurfaceMuted = Color(0xFFCBD5E1);
    const Color primaryOnDark = Color(0xFF9EC5FF);

    final ColorScheme scheme = ColorScheme.dark(
      primary: primaryOnDark,
      onPrimary: ColorManger.kPrimaryDark,
      primaryContainer: Color(0xFF1E3A5F),
      onPrimaryContainer: ColorManger.primaryFixed,
      secondary: onSurfaceMuted,
      onSecondary: ColorManger.kPrimaryDark,
      surface: surface,
      onSurface: onSurfaceMain,
      onSurfaceVariant: onSurfaceMuted,
      error: Color(0xFFFF8A80),
      onError: ColorManger.kPrimaryDark,
      outline: Color(0xFF5A6D85),
      surfaceContainerHighest: surfaceHigh,
    );

    final TextTheme darkTextBase = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    ).textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[CitifixPalette.dark()],
      colorScheme: scheme,
      textTheme: darkTextBase.copyWith(
        displayLarge: darkTextBase.displayLarge?.copyWith(color: onSurfaceMain),
        displayMedium: darkTextBase.displayMedium?.copyWith(color: onSurfaceMain),
        displaySmall: darkTextBase.displaySmall?.copyWith(color: onSurfaceMain),
        headlineLarge: darkTextBase.headlineLarge?.copyWith(color: onSurfaceMain),
        headlineMedium: darkTextBase.headlineMedium?.copyWith(color: onSurfaceMain),
        headlineSmall: darkTextBase.headlineSmall?.copyWith(color: onSurfaceMain),
        titleLarge: darkTextBase.titleLarge?.copyWith(color: onSurfaceMain),
        titleMedium: darkTextBase.titleMedium?.copyWith(color: onSurfaceMain),
        titleSmall: darkTextBase.titleSmall?.copyWith(color: onSurfaceMain),
        bodyLarge: darkTextBase.bodyLarge?.copyWith(
          color: onSurfaceMain,
          height: 1.4,
        ),
        bodyMedium: darkTextBase.bodyMedium?.copyWith(
          color: onSurfaceMain,
          height: 1.4,
        ),
        bodySmall: darkTextBase.bodySmall?.copyWith(color: onSurfaceMuted),
        labelLarge: darkTextBase.labelLarge?.copyWith(color: onSurfaceMain),
        labelMedium: darkTextBase.labelMedium?.copyWith(color: onSurfaceMuted),
        labelSmall: darkTextBase.labelSmall?.copyWith(color: onSurfaceMuted),
      ),
      scaffoldBackgroundColor: ColorManger.kPrimaryDark,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surfaceHigh,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: const DividerThemeData(color: Color(0xFF334155)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOnDark,
          foregroundColor: ColorManger.kPrimaryDark,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: accent,
        selectionColor: accent.withValues(alpha: 0.45),
        cursorColor: primaryOnDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceHigh,
        labelStyle: TextStyle(color: onSurfaceMuted),
        hintStyle: TextStyle(color: onSurfaceMuted.withValues(alpha: 0.85)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: scheme.outline),
        ),
      ),
    );
  }
}
