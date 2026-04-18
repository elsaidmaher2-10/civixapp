import 'package:citifix/core/cubit/theme/theme_cubit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void showThemePicker(BuildContext context) {
  final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
  final String title = isArabic ? 'اختر المظهر' : 'Choose theme';
  final String lightLabel = isArabic ? 'فاتح' : 'Light';
  final String darkLabel = isArabic ? 'داكن' : 'Dark';
  final String systemLabel = isArabic ? 'النظام' : 'System';

  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(ScreenUtilsManager.r16),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.h20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w700,
                fontSize: ScreenUtilsManager.s18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h12),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, currentMode) {
                return SegmentedButton<ThemeMode>(
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: context.palette.kPrimary,
                    selectedForegroundColor: Colors.white,
                  ),
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.light,
                      label: Text(lightLabel),
                      icon: const Icon(Icons.light_mode_outlined),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.dark,
                      label: Text(darkLabel),
                      icon: const Icon(Icons.dark_mode_outlined),
                    ),
                    ButtonSegment<ThemeMode>(
                      value: ThemeMode.system,
                      label: Text(systemLabel),
                      icon: const Icon(Icons.smartphone_outlined),
                    ),
                  ],
                  selected: {currentMode},
                  onSelectionChanged: (selection) {
                    if (selection.isEmpty) return;
                    context.read<ThemeCubit>().setThemeMode(selection.first);
                  },
                );
              },
            ),
            SizedBox(height: ScreenUtilsManager.h8),
          ],
        ),
      );
    },
  );
}
