// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/home/presentation/view/widget/SimpleDropdown.dart';

class ReportFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<String> categories;
  final Function(dynamic) onCategoryChanged;
  final SingleSelectController<dynamic> controller;
  const ReportFormFields({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.categories,
    required this.onCategoryChanged,
    required this.controller,
  }) : super(key: key);

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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Title is required';
            }
            if (value.length < 3) {
              return 'Title must be at least 3 characters';
            }
            return null;
          },
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Description is required';
            }
            if (value.length < 10) {
              return 'Description must be at least 10 characters';
            }
            return null;
          },
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
        SimpleDropdown(
          items: categories,
          onChanged: onCategoryChanged,
          controller: controller,
        ),
      ],
    );
  }
}
