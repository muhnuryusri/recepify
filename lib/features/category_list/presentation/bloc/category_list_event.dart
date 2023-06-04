part of 'category_list_bloc.dart';

abstract class CategoryListEvent extends Equatable {
  const CategoryListEvent();

  @override
  List<Object> get props => [];
}

class GetListForCategory extends CategoryListEvent {}

class SelectCategory extends CategoryListEvent {
  final String categorySelected;

  const SelectCategory({
    required this.categorySelected,
  });

  @override
  List<Object> get props => [categorySelected];
}
