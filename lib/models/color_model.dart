import 'package:flutter/material.dart';

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

class ColorModel {
  final String? colorName;
  final String? colorCode;

  ColorModel({this.colorName, this.colorCode});

  // static List<ColorModel> colorList() {
  //   return colorMap.entries
  //       .map((e) => ColorModel(colorName: e.key, colorCode: e.value))
  //       .toList();
  // }

     factory ColorModel.fromRTDB(Map<String,dynamic> data){
     // print(data['category']);
       print( data['color_code']);
   return ColorModel(
    colorName:  data['color_name'],
    colorCode:   data['color_code']
  );

  
 }

}
