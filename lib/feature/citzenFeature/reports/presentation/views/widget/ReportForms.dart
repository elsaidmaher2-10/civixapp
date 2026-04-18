import 'package:citifix/feature/citzenFeature/reports/data/Models/catogory/categorymodels.dart';
import 'package:flutter/material.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/SimpleDropdown.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<CategoryItem> categories = const [];
  final dynamic Function(CategoryItem?) onCategoryChanged;

  const ReportFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, S.of(context).reportTitleLabel),
        SizedBox(height: ScreenUtilsManager.h16),
        CustomTextfromfield(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).titleIsRequired;
            }
            if (value.length < 3) {
              return S.of(context).titleTooShort;
            }
            return null;
          },
          hinttext: S.of(context).reportTitleHint,
          lable: S.of(context).reportTitleLabel,
          controller: titleController,
        ),

        SizedBox(height: ScreenUtilsManager.h24),

        _buildSectionTitle(context, S.of(context).descriptionLabel),
        SizedBox(height: ScreenUtilsManager.h16),
        CustomTextfromfield(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).descriptionIsRequired;
            }
            if (value.length < 10) {
              return S.of(context).descriptionTooShort;
            }
            return null;
          },
          maxLines: 4,
          hinttext: S.of(context).descriptionHint,
          lable: S.of(context).descriptionLabel,
          controller: descriptionController,
        ),

        SizedBox(height: ScreenUtilsManager.h24),

        _buildSectionTitle(context, S.of(context).selectCategory),
        SizedBox(height: ScreenUtilsManager.h16),
        CategoryDropdown(onChanged: onCategoryChanged,  ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.cairo(
        color: context.palette.kPrimary,
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtilsManager.s16,
      ),
    );
  }
}
