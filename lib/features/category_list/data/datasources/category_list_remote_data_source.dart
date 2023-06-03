import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recepify/core/error/exceptions.dart';

import '../models/category_list_model.dart';

abstract class CategoryListRemoteDataSource {
  Future<CategoryListModel> getCategoryList();
}

class CategoryListRemoteDataSourceImpl implements CategoryListRemoteDataSource {
  final Dio client;

  CategoryListRemoteDataSourceImpl({required this.client});

  @override
  Future<CategoryListModel> getCategoryList() async {
    final response = await client.get(
        'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
        options: Options(headers: {'Content-Type': 'application/json'}));

    if (response.statusCode == 200) {
      final responseData = response.data;
      final categoryListModel =
          CategoryListModel.fromJson(json.decode(responseData));
      return categoryListModel;
    } else {
      throw ServerExceptions();
    }
  }
}
