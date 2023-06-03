import 'dart:convert';

import 'package:mocktail/mocktail.dart';
import 'package:recepify/core/error/exceptions.dart';
import 'package:recepify/features/category_list/data/datasources/category_list_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recepify/features/category_list/data/models/category_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late CategoryListLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = CategoryListLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getCachedCategoryList', () {
    final jsonString = fixture('category.json');
    final expectedCategoryList =
        CategoryListModel.fromJson(json.decode(jsonString));

    test('should return cached CategoryList when available', () async {
      when(() => mockSharedPreferences.getString(any())).thenReturn(jsonString);

      final result = await dataSource.getCachedCategoryList();

      expect(
          result.categoryList.length,
          equals(expectedCategoryList
              .categoryList.length)); // Compare the lengths of the meals lists

      for (var i = 0; i < result.categoryList.length; i++) {
        expect(
            result.categoryList[i].category,
            equals(expectedCategoryList.categoryList[i]
                .category)); // Compare the strCategory properties
      }

      verify(() => mockSharedPreferences.getString(CACHED_CATEGORY_LIST))
          .called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });

    test('should throw CacheException when there is no cached value', () async {
      // Arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // Act
      final call = dataSource.getCachedCategoryList;
      // Assert
      expect(
          () => call(),
          throwsA(const TypeMatcher<
              CacheExceptions>())); // Compare the lengths of the meals lists
    });
  });

  group('cacheCategoryList', () {
    final tCategoryListModel = CategoryListModel(categoryList: [
      CategoryDataModel(category: 'Test1'),
      CategoryDataModel(category: 'Test2'),
      CategoryDataModel(category: 'Test3'),
    ]);
    test('should call SharedPreferences to cache the data', () async {
      final expectedJsonString = json.encode(tCategoryListModel.toJson());
      
      when(() => mockSharedPreferences.setString(CACHED_CATEGORY_LIST, expectedJsonString))
          .thenAnswer((_) =>
              Future.value(true)); // Configure the return value of setString
      // Act
      await dataSource.cacheCategoryList(tCategoryListModel);
      // Assert
      verify(() => mockSharedPreferences.setString(
          CACHED_CATEGORY_LIST, expectedJsonString)).called(1);
    });
  });
}
