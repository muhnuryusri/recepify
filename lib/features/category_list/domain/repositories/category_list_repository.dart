import 'package:dartz/dartz.dart';
import 'package:recepify/core/error/failures.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';

abstract class CategoryListRepository {
  Future<Either<Failure, CategoryList>> getCategoryList();
}