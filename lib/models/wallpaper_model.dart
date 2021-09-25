import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class WallpaperModel {
  int id;
  String category;
  String colorCode;
  String colorName;
  String description;
  int downloads;
  String imageUrlLow;
  String title;
  String type;
  String uploadDate;
  String url;
  String medUrl;
  RxBool isFavorite;

  WallpaperModel(
      {required this.id,
      required this.category,
      required this.colorCode,
      required this.colorName,
      required this.description,
      required this.downloads,
      required this.imageUrlLow,
      required this.title,
      required this.type,
      required this.uploadDate,
      required this.url,
      required this.medUrl,
      required this.isFavorite});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    colorCode = json['color_code'];
    colorName = json['color_name'];
    description = json['description'];
    downloads = json['downloads'];
    imageUrlLow = json['image_url_low'];
    title = json['title'];
    type = json['type'];
    uploadDate = json['uploadDate'];
    url = json['url'];
    medUrl = json['med_url'];
    isFavorite = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['color_code'] = this.colorCode;
    data['color_name'] = this.colorName;
    data['description'] = this.description;
    data['downloads'] = this.downloads;
    data['image_url_low'] = this.imageUrlLow;
    data['title'] = this.title;
    data['type'] = this.type;
    data['uploadDate'] = this.uploadDate;
    data['url'] = this.url;
    data['med_url'] = this.medUrl;
    return data;
  }
}

// class WallpaperModel {
//   int? id;
//   String? category;
//   String? wallpaperType;
//   String? colorCode;
//   String? wallpaperKey;
//   String? uploadDate;
//   String? imageURLLow;
//   get getImageURLLow => this.imageURLLow;

//  set setImageURLLow( imageURLLow) => this.imageURLLow = imageURLLow;
//   int downloads;
//  int get getDownloads => this.downloads;

//  set setDownloads(int downloads) => this.downloads = downloads;
//   String? title;
//   String? description;
//   String? imgUrl;
//   String? colorName;
//   RxBool isFavorite;

  

//   RxBool get getIsFavorite => this.isFavorite;

//   set setIsFavorite(RxBool isFavorite) => this.isFavorite = isFavorite;

//   get getColorName => this.colorName;

//   set setColorName(colorName) => this.colorName = colorName;

//   get colorcode => this.colorCode;

//   set colorcode(value) => this.colorCode = value;

//   String? get getWallpaperType => this.wallpaperType;

//   set setWallpaperType(String? wallpaperType) =>
//       this.wallpaperType = wallpaperType;

//   get getId => this.id;

//   set setId(id) => this.id = id;

//   get getCategory => this.category;

//   set setCategory(category) => this.category = category;

//   get getTitle => this.title;

//   set setTitle(title) => this.title = title;

//   get getDescription => this.description;

//   set setDescription(description) => this.description = description;

//   get getImgUrl => this.imgUrl;

//   set setImgUrl(imgUrl) => this.imgUrl = imgUrl;

//   WallpaperModel(
//       {this.id,
//       this.category,
//       this.wallpaperType,
//       this.colorCode,
//       this.title,
//       this.description,
//       this.imgUrl,
//       this.colorName,
//       required this.downloads,
//       this.imageURLLow,
//       this.uploadDate,
//       this.wallpaperKey,
//       required this.isFavorite});

//   factory WallpaperModel.fromRTDB(Map<String, dynamic> data,String key) {
   
//     return WallpaperModel(
//       id: data['id'],
//       category: data['category'],
//       wallpaperType: data['type'],
//       colorCode: data['color_code'],
//       title: data['title'],
//       description: data['desc'],
//       imgUrl: data['url'],
//       colorName: data['color_name'],
//       downloads: data['downloads'],
//       imageURLLow: data['image_url_low'],
//       uploadDate: data['uploadDate'],
//       wallpaperKey: key,
//       isFavorite: false.obs,
//     );
//   }
// }
