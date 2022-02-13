import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// To parse this JSON data, do
//
//     final wallpaperModel = wallpaperModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WallpaperModel wallpaperModelFromJson(String str) => WallpaperModel.fromJson(json.decode(str));

String wallpaperModelToJson(WallpaperModel data) => json.encode(data.toJson());

class WallpaperModel {
    WallpaperModel(
         this.code,
         this.data,
         this.received,
     );

    int code;
    List<WallpaperData> data;
    bool received;

    factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
        json["code"],
       List<WallpaperData>.from(json["data"].map((x) => WallpaperData.fromJson(x))),
        json["received"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "received": received,
    };
}

class WallpaperData {
    WallpaperData(
         this.id,
        this.category,
        this.colorCode,
         this.colorName,
         this.desc,
         this.downloads,
       
         this.title,
         this.type,
         this.uploadDate,
         this.url,
         this.isFavorite
    );

    int id;
    String category;
    String colorCode;
    String colorName;
    String desc;
    int downloads;
   
    String title;
    String type;
    DateTime uploadDate;
    String url;
     RxBool isFavorite = false.obs;

    factory WallpaperData.fromJson(Map<String, dynamic> json) => WallpaperData(
       json["id"],
       json["category"],
       json["color_code"],
   json["color_name"],
        json["desc"],
       json["downloads"],
     
       json["title"],
        json["type"],
        DateTime.parse(json["uploadDate"]),
       json["url"],
       false.obs,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "color_code": colorCode,
        "color_name": colorName,
        "desc": desc,
        "downloads": downloads,
      
        "title": title,
        "type": type,
        "uploadDate": uploadDate.toIso8601String(),
        "url": url,
        
    };
}



// class WallpaperModel {
//   int id = 0;
//   String category = "";
//   String colorCode = "";
//   String colorName = "";
//   String description = "";
//   int downloads = 0;
//   String imageUrlLow = "";
//   String title = "";
//   String type = "";
//   String uploadDate = "";
//   String url = "";
 
//   RxBool isFavorite = false.obs;

//   WallpaperModel(
//       {required this.id,
//       required this.category,
//       required this.colorCode,
//       required this.colorName  ,
//       required this.description,
//       required this.downloads,
//       required this.imageUrlLow,
//       required this.title,
//       required this.type,
//       required this.uploadDate,
//       required this.url,
    
//       required isFavorite = false.obs;});

//   WallpaperModel.fromJson(Map<String, dynamic> json, String key) {
//     id = json['id'];
//     category = json['category'];
//     colorCode = json['color_code'];
//     colorName = json['color_name'];
//     description = json['description'];
//     downloads = json['downloads'];
//     imageUrlLow = json['image_url_low'];
//     title = json['title'];
//     type = json['type'];
//     uploadDate = json['uploadDate'];
//     url = json['url'];
  
//     isFavorite = false.obs;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['category'] = this.category;
//     data['color_code'] = this.colorCode;
//     data['color_name'] = this.colorName;
//     data['description'] = this.description;
//     data['downloads'] = this.downloads;
//     data['image_url_low'] = this.imageUrlLow;
//     data['title'] = this.title;
//     data['type'] = this.type;
//     data['uploadDate'] = this.uploadDate;
//     data['url'] = this.url;
   
//     return data;
//   }
// }

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
