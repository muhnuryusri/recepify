import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recepify/core/usecases/usecase.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';
import 'package:recepify/features/category_list/domain/usecases/get_category_list.dart';
import 'package:recepify/features/category_list/presentation/bloc/category_list_bloc.dart';

class MockGetCategoryList extends Mock implements GetCategoryList {}

void main() {
  late CategoryListBloc categoryListBloc;
  late MockGetCategoryList mockGetCategoryList;

  setUp(() {
    mockGetCategoryList = MockGetCategoryList();
    categoryListBloc = CategoryListBloc(getCategoryList: mockGetCategoryList);
  });

  setUpAll(() {
    registerFallbackValue(
        NoParams()); // Menyediakan instance dummy dari NoParams
  });

  tearDown(() {
    categoryListBloc.close();
  });

  test('initial state is correct', () {
    // Verifikasi bahwa state awal CategoryBloc sesuai dengan yang diharapkan
    expect(categoryListBloc.state, equals(CategoryListInitial()));
  });

  group('getCategoryList', () {
    final tCategoryList = CategoryList(categoryList: [
      CategoryData(category: 'Beef'),
      CategoryData(category: 'Breakfast'),
      CategoryData(category: 'Chicken'),
    ]);

    blocTest(
      'emits [CategoryListLoading, CategoryListLoaded] when GetListInCategory event is added',
      build: () => categoryListBloc,
      act: (bloc) => bloc.add(GetListForCategory()),
      expect: () => {
        CategoryListLoading(),
        CategoryListLoaded(list: tCategoryList),
      },
    );
  });
}
