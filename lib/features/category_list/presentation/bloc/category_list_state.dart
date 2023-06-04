part of 'category_list_bloc.dart';

abstract class CategoryListState extends Equatable {
  const CategoryListState();

  @override
  List<Object> get props => [];
}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  final CategoryList list;

  const CategoryListLoaded({required this.list});

  @override
  List<Object> get props => [list];
}

class CategorySelected extends CategoryListState {
  final String categorySelected;

  const CategorySelected({required this.categorySelected});

  @override
  List<Object> get props => [categorySelected];
}

class CategoryListError extends CategoryListState {
  final String errorMessage;

  const CategoryListError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}