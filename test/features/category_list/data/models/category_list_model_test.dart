import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recepify/features/category_list/data/models/category_list_model.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tCategoryListModel = CategoryListModel(
    categoryList: [
      CategoryDataModel(category: 'Beef'),
      CategoryDataModel(category: 'Breakfast'),
      CategoryDataModel(category: 'Chicken'),
    ]
  );

  test(
    'should be a subclass of CategoryList entity',
    () async {
      // Assert
      expect(tCategoryListModel, isA<CategoryList>());
    }
  );

  group('fromJson', () {
    test(
      'should return a valid model when JSON category is a string',
      () async {
        // Arrange
        final Map<String, dynamic> jsonMap = 
          json.decode(fixture('category.json'));
        
        // Act
        final result = CategoryListModel.fromJson(jsonMap);

        // Assert
        expect(result.categoryList.length, tCategoryListModel.categoryList.length);
        for (int i = 0; i < result.categoryList.length; i++) {
          expect(result.categoryList[i].category, tCategoryListModel.categoryList[i].category);
        }
    });
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // Act
        final result = tCategoryListModel.toJson();

        // Assert
        final expectedMap = {
            "meals": [
                {
                    "strCategory": "Beef"
                },
                {
                    "strCategory": "Breakfast"
                },
                {
                    "strCategory": "Chicken"
                }
            ]
        };
        expect(result, expectedMap);
    });
  });
}