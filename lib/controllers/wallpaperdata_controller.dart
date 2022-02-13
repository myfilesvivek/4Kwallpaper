import 'package:get/get.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// class WallpaperDataController extends GetxController{


  
//   final String apiURL = 'http://localhost/WallpaperMixAdminPanel/wallpaperlist.php';

//    Future<List<WallpaperModel>> fetchStudents() async {
 
//     var response = await http.get(Uri.parse(apiURL));
 
//     if (response.statusCode == 200) {
 
//       final items = json.decode(response.body).cast<Map<String, dynamic>>();
 
//       List<WallpaperModel> studentList = items.map<WallpaperModel>((json) {
//         return WallpaperModel.fromJson(json);
//       }).toList();
 
//       return studentList;
//       }
//      else {
//       throw Exception('Failed to load data from Server.');
//     }
//   }

  

// }