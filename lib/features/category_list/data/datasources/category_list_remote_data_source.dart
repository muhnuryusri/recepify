import 'package:recepify/features/category_list/data/models/category_list_model.dart';

abstract class CategoryListRemoteDataSource {
  Future<CategoryListModel> getCategoryList();
}