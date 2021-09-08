class CategoryModel {
  final categoryName;
  final categoryImageUrl;
  final categoryPriority;
  final int totalWallpapers;

  CategoryModel(this.categoryName, this.categoryImageUrl, this.categoryPriority,
      this.totalWallpapers);

  factory CategoryModel.fromRTDB(Map<String, dynamic> data) {
    // print(data['category']);
    return CategoryModel(
      data['desc'],
      data['thumbnail'],
      data['priority'],
      data['totalWallpapers'],
    );
  }
}
