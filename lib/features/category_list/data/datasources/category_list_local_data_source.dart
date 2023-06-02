import 'package:recepify/features/category_list/data/models/category_list_model.dart';

abstract class CategoryListLocalDataSource {
  Future<CategoryListModel> getCachedCategoryList();
  Future<void> cacheCategoryList(CategoryListModel category);
}