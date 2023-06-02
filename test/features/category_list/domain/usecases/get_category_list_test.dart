import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recepify/core/usecases/usecase.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';
import 'package:recepify/features/category_list/domain/repositories/category_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recepify/features/category_list/domain/usecases/get_category_list.dart';

class MockCategoryListRepository extends Mock implements CategoryListRepository {
  
}

void main() {
  late GetCategoryList usecase;
  late MockCategoryListRepository mockCategoryListRepository;

  setUp(() {
    mockCategoryListRepository = MockCategoryListRepository();
    usecase = GetCategoryList(mockCategoryListRepository);
  });

  final tCategoryList =
      CategoryList(
        categoryList: [
          CategoryData(category: 'Beef'),
          CategoryData(category: 'Chicken'),
          CategoryData(category: 'Breakfast'),
        ]
      );

  test(
    'should get category list from repository',
    () async {
      // Arrange
      when(() => mockCategoryListRepository.getCategoryList())
          .thenAnswer((_) async => Right(tCategoryList));

      // Act
      final result = await usecase(NoParams()); // assuming execute is the function to execute the use case

      // Assert
      expect(result, Right(tCategoryList));
      verify(() => mockCategoryListRepository.getCategoryList());
      verifyNoMoreInteractions(mockCategoryListRepository);
    },
  );
}
