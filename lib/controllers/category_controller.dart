import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/routes/api.routes.dart';

class CategoryController extends GetxController {
 
  static CategoryController instance = Get.find();

 // final _database = FirebaseDatabase.instance.reference();

 // RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
 // final wallAllList = <WallpaperData>[];

   final client = http.Client();

  @override
  void onInit() {
    //categoryList.bindStream(getAllCategory());
   // wallAllList.addAll(wallPapaerController.wallpaperList);
    super.onInit();
  }

    final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
     "Connection": "keep-alive",
    "Access-Control-Allow-Origin": "*"
  };

  Future getAllCategory() async{
  //  final _catStream = _database.child("categories").onValue;
  //  final catFullList = <String>[];

    final String subUrl = "/category/getcategory";

     final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    
  
    try{

         http.Response response =  await  client.get(uri,headers: headers);

      final statusCode = response.statusCode;
      final body = response.body;

      var categoryModel = CategoryModel.fromJson(jsonDecode(body));

        var categoryStatusCode = categoryModel.code;
      var categoryData = categoryModel.data;

      if (statusCode == 200) {
          print(body);
      }
   


    // final streamToPublish = _catStream.map((event) {
    //   final wallMap = Map<String, dynamic>.from(event.snapshot.value);
    //   final wallList = wallMap.entries.map((element) {
      

    //     catFullList.add(element.key.toString());

       

    //     return CategoryModel.fromRTDB(Map<String, dynamic>.from(element.value));
    //   }).toList();

    //   return wallList;
    // });


    
    return categoryData;

    }catch(e){
     
      Get.snackbar(e.toString(),"");

    }

  }

 
}
