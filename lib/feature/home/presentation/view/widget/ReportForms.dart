import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/home/presentation/view/widget/SimpleDropdown.dart';
import 'package:flutter/material.dart';

class ReportFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<String> categories;
  final Function(dynamic) onCategoryChanged;

  const ReportFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.categories,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constantmanger.ReportTitle1,
          style: TextStyle(
            color: ColorManger.kprimary,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtilsManager.s16,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        CustomTextfromfield(
          hinttext: Constantmanger.ReportTitle,
          lable: Constantmanger.ReportTitle1,
          controller: titleController,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        Text(
          Constantmanger.descriptionTitle,
          style: TextStyle(
            color: ColorManger.kprimary,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtilsManager.s16,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        CustomTextfromfield(
          maxLines: 3,
          hinttext: Constantmanger.hintReportDescription,
          lable: Constantmanger.labeldescription,
          controller: descriptionController,
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        Text(
          Constantmanger.selectcategory,
          style: TextStyle(
            color: ColorManger.kprimary,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtilsManager.s16,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        SimpleDropdown(items: categories, onChanged: onCategoryChanged),
      ],
    );
  }
}
