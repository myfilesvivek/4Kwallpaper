// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
    CategoryModel(
        this.code,
        this.data,
        this.received,
    );

    int? code;
    List<CategoryData>? data;
    bool? received;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        json["code"],
        List<CategoryData>.from(json["data"].map((x) => CategoryData.fromJson(x))),
         json["received"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "received": received,
    };
}

class CategoryData {
    CategoryData(
        this.id,
        this.categoryName,
        this.desc,
        this.priority,
        this.thumbnail,
      
    );

    int? id;
    String? categoryName;
    String? desc;
    String? priority;
    String? thumbnail;
   // int? totalWallpapers;

    factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
         json["id"],
         json["category_name"],
         json["desc"],
         json["priority"],
         json["thumbnail"],
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "desc": desc,
        "priority": priority,
        "thumbnail": thumbnail,
        
    };
}





// class CategoryModel {
//   final categoryName;
//   final categoryImageUrl;
//   final categoryPriority;
//   final int totalWallpapers;

//   CategoryModel(this.categoryName, this.categoryImageUrl, this.categoryPriority,
//       this.totalWallpapers);

//   factory CategoryModel.fromRTDB(Map<String, dynamic> data) {
//     // print(data['category']);
//     return CategoryModel(
//       data['desc'],
//       data['thumbnail'],
//       data['priority'],
//       data['totalWallpapers'],
//     );
//   }
// }
