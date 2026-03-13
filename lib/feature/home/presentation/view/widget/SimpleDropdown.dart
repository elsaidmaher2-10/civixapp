import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/feature/home/data/Models/catogory/categorymodels.dart';
import 'package:citifix/feature/home/data/Repos/categortrepos/categoryrepos.dart';
import 'package:citifix/feature/home/presentation/manager/cubit/categoryCubit/category_cubit.dart';
import 'package:citifix/feature/home/presentation/manager/cubit/categoryCubit/category_state.dart';
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

  final Function(dynamic)? onChanged;
  final SingleSelectController<dynamic>? controller;
  final dynamic initialItem;
  final String? hintText;
  final String? Function(dynamic)? validator;
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
            return CustomDropdown<dynamic>.search(
              items: [],
              onChanged: onChanged,
              controller: controller,
              initialItem: initialItem,
              hintText: hintText ?? 'Select Category',
              validator: validator,
              decoration: decoration,
              validateOnChange: true,
              maxlines: 1,
            );
          } else if (state is CategoryLoaded) {
            final categories = state.categories
                .map((e) => e.name ?? '')
                .toList();

            return CustomDropdown<dynamic>.search(
              items: categories,
              onChanged: onChanged,
              controller: controller,
              initialItem: initialItem,
              hintText: hintText ?? 'Select Category',
              validator: validator,
              decoration: decoration,
              validateOnChange: true,
              maxlines: 1,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
