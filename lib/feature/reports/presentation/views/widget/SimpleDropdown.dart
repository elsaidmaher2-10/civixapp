import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/reports/presentation/manager/categoryManger/category_cubit.dart';
import 'package:citifix/feature/reports/presentation/manager/categoryManger/category_state.dart';
import 'package:citifix/feature/reports/data/Models/catogory/categorymodels.dart';
import 'package:citifix/feature/reports/data/repos/categortrepos/categoryrepos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    Key? key,
    required this.onChanged,
    this.controller,
    this.initialItem,
    this.hintText,
    this.validator,
    this.decoration,
  }) : super(key: key);

  final Function(CategoryItem?) onChanged;
  final SingleSelectController<CategoryItem?>? controller;
  final CategoryItem? initialItem;
  final String? hintText;
  final String? Function(CategoryItem?)? validator;
  final CustomDropdownDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(
        CategoryRepository(
          service: getIt<Apiservice>(),
          internetChecker: getIt<InternetChecker>(),
        ),
      )..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return CustomDropdown<CategoryItem?>.search(
              items: const [],
              onChanged: (_) {},
              hintText: 'Loading Categories...',
              decoration: decoration,
            );
          } else if (state is CategoryLoaded) {
            return CustomDropdown<CategoryItem?>.search(
              items: state.categories,
              headerBuilder: (context, selectedItem, enabled) => Text(
                selectedItem?.name ?? '',
                style: const TextStyle(fontSize: 14),
              ),
              listItemBuilder: (context, item, isSelected, onItemSelect) =>
                  Text(item?.name ?? '', style: const TextStyle(fontSize: 14)),
              onChanged: onChanged,
              controller: controller,
              initialItem: initialItem,
              hintText: hintText ?? 'Select Category',
              validator: validator,
              decoration:
                  decoration ??
                  CustomDropdownDecoration(
                    closedFillColor: const Color(0xffF6F6F6),
                    closedBorder: Border.all(color: ColorManger.kPrimary),
                  ),
            );
          } else if (state is CategoryError) {
            return const Text(
              "Failed to load categories",
              style: TextStyle(color: Colors.red),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
