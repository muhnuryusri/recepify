import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recepify/core/error/exceptions.dart';
import 'package:recepify/core/error/failures.dart';
import 'package:recepify/core/platform/network_info.dart';
import 'package:recepify/features/category_list/data/datasources/category_list_local_data_source.dart';
import 'package:recepify/features/category_list/data/datasources/category_list_remote_data_source.dart';
import 'package:recepify/features/category_list/data/models/category_list_model.dart';
import 'package:recepify/features/category_list/data/repositories/category_list_repository_impl.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';

class MockRemoteDataSource extends Mock
    implements CategoryListRemoteDataSource {}

class MockLocalDataSource extends Mock implements CategoryListLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CategoryListRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CategoryListRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getCategoryList', () {
    const tCategory = 'Beef';
    final tCategoryListModel = CategoryListModel(
        categoryList: [CategoryDataModel(category: tCategory)]);

    final CategoryList tCategoryList = tCategoryListModel;

    test('should check if the device is online', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getCategoryList())
          .thenAnswer((_) async => tCategoryListModel);
      // Act
      final result = await repository.getCategoryList();

      // Assert
      verify(() => mockNetworkInfo.isConnected);
      expect(result, equals(Right(tCategoryList)));
    });

    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call is successful', () async {
        // Arrange
        when(() => mockRemoteDataSource.getCategoryList())
            .thenAnswer((_) async => tCategoryListModel);

        // Act
        final result = await repository.getCategoryList();

        // Assert
        verify(() => mockRemoteDataSource.getCategoryList());
        expect(result, equals(Right(tCategoryList)));
      });

      test('should cache the data locally when the call is successful',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.getCategoryList())
            .thenAnswer((_) async => tCategoryListModel);

        // Act
        await repository.getCategoryList();

        // Assert
        verify(() => mockRemoteDataSource.getCategoryList());
        verifyNever(
            () => mockLocalDataSource.cacheCategoryList(tCategoryListModel));
      });

      test('should return server failure when the call is unsuccessful',
          () async {
        // Arrange
        when(() => mockRemoteDataSource.getCategoryList())
            .thenThrow(ServerExceptions());

        // Act
        final result = await repository.getCategoryList();

        // Assert
        verify(() => mockRemoteDataSource.getCategoryList());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, Left<Failure, CategoryList>(ServerFailure()));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // Arrange
        when(() => mockLocalDataSource.getCachedCategoryList())
            .thenAnswer((_) async => tCategoryListModel);

        // Act
        final result = await repository.getCategoryList();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachedCategoryList());
        expect(result, equals(Right(tCategoryList)));
      });

      test(
          'should return cache failure when no cached data is present',
          () async {
        // Arrange
        when(() => mockLocalDataSource.getCachedCategoryList())
            .thenThrow(CacheExceptions());

        // Act
        final result = await repository.getCategoryList();

        // Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getCachedCategoryList());
        expect(result, Left<Failure, CategoryList>(CacheFailure()));
      });
    });
  });
}
