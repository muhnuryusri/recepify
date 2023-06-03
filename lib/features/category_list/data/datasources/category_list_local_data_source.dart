import 'dart:convert';

import 'package:recepify/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category_list_model.dart';

const CACHED_CATEGORY_LIST = 'CACHED_CATEGORY_LIST';

abstract class CategoryListLocalDataSource {
  Future<CategoryListModel> getCachedCategoryList();
  Future<void> cacheCategoryList(CategoryListModel category);
}

class CategoryListLocalDataSourceImpl implements CategoryListLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<CategoryListModel> getCachedCategoryList() {
    final jsonString = sharedPreferences.getString(CACHED_CATEGORY_LIST);
    if (jsonString != null) {
      return Future.value(CategoryListModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExceptions();
    }
  }

  @override
  Future<void> cacheCategoryList(CategoryListModel category) {
    final jsonString = json.encode(category.toJson());
    return sharedPreferences.setString(CACHED_CATEGORY_LIST, jsonString);
  }
}
