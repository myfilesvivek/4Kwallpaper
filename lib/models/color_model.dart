import 'package:flutter/material.dart';
import 'dart:convert';

var colorMap = {
  'blue': Colors.blue,
  'red': Colors.red,
  'yellow': Colors.yellow,
  'green': Colors.green,
  'purple': Colors.purple,
  'orange': Colors.orange,
  'blue2': Colors.blue,
  'red2': Colors.red,
  'yellow2': Colors.yellow,
  'green2': Colors.green,
  'purple2': Colors.purple,
  'orange2': Colors.orange,
  'black': Colors.black,
  'white': Colors.white,
};

// To parse this JSON data, do
//
//     final colorModel = colorModelFromJson(jsonString);



ColorModel colorModelFromJson(String str) => ColorModel.fromJson(json.decode(str));

String colorModelToJson(ColorModel data) => json.encode(data.toJson());

class ColorModel {
    ColorModel(
        this.code,
        this.data,
        this.received,
    );

    int code;
    List<ColorData> data;
    bool received;

    factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
       json["code"],
         List<ColorData>.from(json["data"].map((x) => ColorData.fromJson(x))),
         json["received"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "received": received,
    };
}

class ColorData {
    ColorData(
        this.id,
        this.colorCode,
        this.colorName,
        this.priority,
    );

    int id;
    String colorCode;
    String colorName;
    String priority;

    factory ColorData.fromJson(Map<String, dynamic> json) => ColorData(
         json["id"],
         json["color_code"],
      json["color_name"],
      json["priority"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "color_code": colorCode,
        "color_name": colorName,
        "priority": priority,
    };
}


// class ColorModel {
//   final String? colorName;
//   final String? colorCode;

//   ColorModel({this.colorName, this.colorCode});

//   // static List<ColorModel> colorList() {
//   //   return colorMap.entries
//   //       .map((e) => ColorModel(colorName: e.key, colorCode: e.value))
//   //       .toList();
//   // }

//      factory ColorModel.fromRTDB(Map<String,dynamic> data){
//      // print(data['category']);
//        print( data['color_code']);
//    return ColorModel(
//     colorName:  data['color_name'],
//     colorCode:   data['color_code']
//   );

  
//  }

//}
