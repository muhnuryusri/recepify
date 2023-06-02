import 'package:dartz/dartz.dart';
import 'package:recepify/features/category_list/domain/entities/category_list.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, CategoryList>> call(Params params);
}

class NoParams {}