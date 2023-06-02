class CategoryData {
  final String category;

  CategoryData({required this.category});

  toJson() {}
}

class CategoryList {
  final List<CategoryData> categoryList;

  CategoryList({required this.categoryList});
}