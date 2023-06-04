
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recepify/core/error/failures.dart';
import 'package:recepify/core/usecases/usecase.dart';

import '../../domain/entities/category_list.dart';
import '../../domain/usecases/get_category_list.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  final GetCategoryList getCategoryList;

  CategoryListBloc({required this.getCategoryList})
      : super(CategoryListInitial()) {
    on<CategoryListEvent>((event, emit) async {
      if (event is GetListForCategory) {
        emit(CategoryListLoading());
        try {
          final categoriesEither = await getCategoryList(NoParams());
          categoriesEither.fold((failure) {
            // Handle failure case
            if (failure is ServerFailure) {
              emit(const CategoryListError(
                  errorMessage: SERVER_FAILURE_MESSAGE));
            } else if (failure is CacheFailure) {
              emit(
                  const CategoryListError(errorMessage: CACHE_FAILURE_MESSAGE));
            } else {
              emit(const CategoryListError(errorMessage: 'Unknown Failure'));
            }
          }, (categories) {
            // Handle success case
            emit(CategoryListLoaded(list: categories));
            print('NULLL : $categories');
          });
        } catch (e, stackTrace) {
          print('Error: $e');
          print('Stack trace: $stackTrace');
          emit(CategoryListError(errorMessage: 'Unexpected Error: $e'));
        }
      }
    });
  }
}
