import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recepify/core/error/exceptions.dart';
import 'package:recepify/features/category_list/data/datasources/category_list_remote_data_source.dart';
import 'package:recepify/features/category_list/data/models/category_list_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CategoryListRemoteDataSourceImpl dataSource;
  late MockDio mockDioClient;

  setUp(() {
    mockDioClient = MockDio();
    dataSource = CategoryListRemoteDataSourceImpl(client: mockDioClient);
  });

  void setUpMockDioClientSuccess200() {
    when(() => mockDioClient
        .get(any(),
            options: any(named: 'options'))).thenAnswer((_) async => Response(
          data: fixture('category.json'),
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));
  }

  void setUpMockDioClientFailure404() {
    when(() => mockDioClient.get(any(), options: any(named: 'options')))
        .thenAnswer((_) async => Response(
            data: 'Something went wrong',
            statusCode: 404,
            requestOptions: RequestOptions(path: '')));
  }

  group('getCategoryList', () {
    final tCategoryListModel =
        CategoryListModel.fromJson(json.decode(fixture('category.json')));
    test(
        'should perform a GET request on a URL with list endpoint and with application/json header',
        () async {
      // Arrange
      setUpMockDioClientSuccess200();
      // Act
      await dataSource.getCategoryList();
      // Assert
      verifyNever(() => mockDioClient.get(
            'https://www.themealdb.com/api/json/v1/1/list.php?c=list',
            options: Options(headers: {'Content-Type': 'application/json'}),
          ));
    });

    test('should return CategoryList when the response code is 200 (success)',
        () async {
      // Arrange
      setUpMockDioClientSuccess200();
      // Act
      final result = await dataSource.getCategoryList();
      // Assert
      expect(jsonEncode(result), equals(jsonEncode(tCategoryListModel)));
    });

    test('should return ServerException when the response code is 404 or other',
        () async {
      // Arrange
      setUpMockDioClientFailure404();
      // Act
      final call = dataSource.getCategoryList;
      // Assert
      expect(() => call(), throwsA(const TypeMatcher<ServerExceptions>()));
    });
  });
}
