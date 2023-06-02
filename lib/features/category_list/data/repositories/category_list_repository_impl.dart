import 'package:dartz/dartz.dart';
import 'package:recepify/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/category_list.dart';
import '../../domain/repositories/category_list_repository.dart';
import '../datasources/category_list_local_data_source.dart';
import '../datasources/category_list_remote_data_source.dart';

class CategoryListRepositoryImpl implements CategoryListRepository {
  final CategoryListRemoteDataSource remoteDataSource;
  final CategoryListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryListRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, CategoryList>> getCategoryList() async {
    // Placeholder implementation
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      // Return a Right with an empty CategoryListlocalDataSource.cacheCategoryList(remoteCategoryList);
      try {
        final remoteCategoryList = await remoteDataSource.getCategoryList();
        return Right(remoteCategoryList);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategoryList = await localDataSource.getCachedCategoryList();
        return Right(localCategoryList);
      } on CacheExceptions {
        return Left(CacheFailure());
      }
    }
  }
}
