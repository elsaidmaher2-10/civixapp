import 'package:citifix/feature/reports/presentation/manager/categoryManger/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/categortrepos/categoryrepos.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryRepository) : super(CategoryInitial());
  CategoryRepository categoryRepository;
  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    categoryRepository.getCategories().then(
      (onvalue) => onvalue.fold((ifLeft) {
        print(ifLeft.errors.join());
        emit(CategoryError(ifLeft.errors.join()));
      }, (ifRight) => emit(CategoryLoaded(ifRight.items))),
    );
  }
}
