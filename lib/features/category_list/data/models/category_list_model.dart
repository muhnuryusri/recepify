import 'package:recepify/features/category_list/domain/entities/category_list.dart';

class CategoryDataModel extends CategoryData {
  CategoryDataModel({
    required String category,
  }) : super(category: category);

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(category: json['strCategory']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "strCategory": category,
    };
  }
}

class CategoryListModel extends CategoryList {
  CategoryListModel({
    required List<CategoryDataModel> categoryList,
  }) : super(categoryList: categoryList);

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categories = json['meals'];
    final categoryList = categories.map((item) => CategoryDataModel.fromJson(item)).toList();
    return CategoryListModel(categoryList: categoryList);
  }

  Map<String, dynamic> toJson() {
    final List<dynamic> categoryListJson =
        categoryList.map((category) => category.toJson()).toList();
    return {'meals': categoryListJson};
  }
}