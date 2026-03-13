// category_cubit.dart
import 'package:citifix/feature/home/data/Repos/categortrepos/categoryrepos.dart';
import 'package:citifix/feature/home/presentation/manager/categoryManger/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryRepository) : super(CategoryInitial());
  CategoryRepository categoryRepository;
  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    categoryRepository.getCategories().then(
      (onvalue) => onvalue.fold(
        (ifLeft) => emit(CategoryError(ifLeft.errors.join())),
        (ifRight) => emit(CategoryLoaded(ifRight.items)),
      ),
    );
  }
}
