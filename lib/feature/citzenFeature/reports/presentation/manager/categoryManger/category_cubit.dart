import 'dart:convert';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/catogory/categorymodels.dart';
import 'package:citifix/feature/citzenFeature/reports/data/repos/categortrepos/categoryrepos.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/categoryManger/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  Future<void> getCachedCategories() async {
    final cached = PrefrenceManager().getstring("categories");
    print("cached");
    if (cached != null) {
      try {
        final List<dynamic> decodedData = jsonDecode(cached);
        final List<CategoryItem> categories = decodedData
            .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(CategoryLoaded(categories));
      } catch (e) {
        await fetchCategories();
      }
    } else {
      await fetchCategories();
    }
  }

  Future<void> fetchCategories() async {
    emit(CategoryLoading());

    final result = await categoryRepository.getCategories();

    result.fold((error) => emit(CategoryError(error.errors.join(", "))), (
      data,
    ) {
      final String jsonString = jsonEncode(
        data.items.map((e) => e.toJson()).toList(),
      );
      PrefrenceManager().setstring("categories", jsonString);

      emit(CategoryLoaded(data.items));
    });
  }
}
