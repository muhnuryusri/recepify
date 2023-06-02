import 'package:recepify/core/error/failures.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/category_list_repository.dart';

class GetCategoryList extends UseCase<CategoryList, NoParams> {
  final CategoryListRepository repository;

  GetCategoryList(this.repository);

  @override
  Future<Either<Failure, CategoryList>> call(NoParams params) async {
    return await repository.getCategoryList();
  }
}