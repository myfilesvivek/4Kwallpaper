import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/routes/api.routes.dart';
import 'package:http/http.dart' as http;


import '../constants.dart';

class WallPaperController extends GetxController {
  static WallPaperController instance = Get.find();

  List<WallpaperData> wallpaperList = [];
  var popularWallList = <WallpaperData>[];
  var trendingWallList = <WallpaperData>[];
  var feauredNWallList = <WallpaperData>[];

   var suggestionList = <String>[];

  // String homescreenimage ="";
  // String homescreenimageLow = "";
  //final favWallList = <WallpaperModel>[].obs;

  var favWallpaperManager;

   final client = http.Client();


  // List<WallpaperModel> get wallAll => wallpaperList.value;

  final _database = FirebaseDatabase.instance.reference();


  @override
  void onInit() {
  

   // wallpaperList.(getAllWallPaper());


    super.onInit();
  }

    final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
     "Connection": "keep-alive",
    "Access-Control-Allow-Origin": "*"
  };

  Future<List<WallpaperData>> getAllWallPaper() async{

     final String subUrl = "/wallpaper/getwallpaper";

    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    
  

   http.Response response =  await  client.get(uri,headers: headers);

      final statusCode = response.statusCode;
      final body = response.body;

      var wallpaperModel = WallpaperModel.fromJson(jsonDecode(body));

        var categoryStatusCode = wallpaperModel.code;
      var categoryData = wallpaperModel.data;

      if (statusCode == 200) {
          print(body);
      }

          popularWallList = categoryData
          .where((c) => c.type == "Popular")
          .toList()
          .reversed
          .toList();

      trendingWallList = categoryData
          .where((c) => c.type == "Trending")
          .toList()
          .reversed
          .toList();

      feauredNWallList = categoryData
          .where((c) => c.type == "Featured")
          .toList()
          .reversed
          .toList();

          wallpaperList = categoryData;

    List<WallpaperData> streamToPublish = categoryData.map((event) {
      //final wallMap = Map<String, dynamic>.from(event.snapshot.value);

      // final wallList = event((element) {
        // var wallpaper = WallpaperModel.fromJson(
        //     Map<String, dynamic>.from(element.value), element.key);
     //   var wallpaper = e

     print('EVENT WALL DATA !!! $event');

        if (isFavorite(event)) {
          event.isFavorite.value = true;
        }

      //  return event;
     // }
    //  ).toList();

        List<String>? mySugg = [];

      wallpaperList.forEach((element) {
       

        mySugg.add(element.title);
          mySugg.add(element.desc);
        
      });

      suggestionList = mySugg.toSet().toList().reversed.toList();

    
  

      //   favWallList.value =
      // wallpaperList.where((c) => c.isFavorite).toList();

     

      return event;
    }).toList();

    return streamToPublish;

    
  }

  
  
//   Future<String> getHomeWallPaper() async{

    
//  final String subUrl = "/header/getheaderbanner";

//     final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);

//      http.Response response =  await  client.get(uri,headers: headers);

//       final statusCode = response.statusCode;
//       final body = response.body;

//       //var wallpaperModel = WallpaperModel.fromJson(jsonDecode(body));

//        // var categoryStatusCode = wallpaperModel.code;
//     //  var categoryData = wallpaperModel.data;
//     Map<String, dynamic> data = jsonDecode(body);

//     String bannerUrl = data['data']['bannerurl'];

//       if (statusCode == 200) {
//           print(body);
//       }


//   }
  
  
  // void closeStream(){
  //   wallpaperList.close();
  // }

  bool isFavorite(WallpaperData wallpaper) {
    return Hive.box(FAV_BOX).get(FAV_LIST_KEY).contains(wallpaper.id);
  }

  RxList<WallpaperData> get likedListItems {
    // Hive.box(FAV_BOX).get(FAV_LIST_KEY).contains(item.id)

    return wallpaperList
        .where((item) => item.isFavorite.value == true)
        .toList()
        .obs;
  }

   List<String> get suggList{
    return suggestionList;
  }

  // Add an item to the wish list
  bool addItem(int id) {
  
    var list = Hive.box(FAV_BOX).get(FAV_LIST_KEY);

    if (!list.contains(id)) {
      list.add(id);
      Hive.box(FAV_BOX).put(FAV_LIST_KEY, list);

      final int index = wallpaperList.indexWhere((item) => item.id == id);
      wallpaperList[index].isFavorite.value = true;

      //  update();
      //  likedListItems();
     
    }
     return true;
  }

  // Remove an item from the wish list
  bool removeItem(int id) {
    var list = Hive.box(FAV_BOX).get(FAV_LIST_KEY);

    if (list.contains(id)) {
      list.remove(id);
      Hive.box(FAV_BOX).put(FAV_LIST_KEY, list);

      final int index = wallpaperList.indexWhere((item) => item.id == id);
      wallpaperList[index].isFavorite.value = false;
      // update();
      // likedListItems();
    }

    return true;
  }

  List<WallpaperData> getListFromCategories(String categoryName) {
    return wallpaperList
        .where((e) => e.category.toLowerCase() == categoryName.toLowerCase())
        .toList();
  }

   List<WallpaperData> getListFromSearch(String searchName) {
    return wallpaperList
        .where((e) => e.title.toLowerCase() == searchName.toLowerCase() ||  e.desc.toLowerCase() == searchName.toLowerCase())
        .toList();
  }

  List<WallpaperData> getListForType(String typeName) {
    return wallpaperList
        .where((e) => e.type.toLowerCase() == typeName.toLowerCase())
        .toList();
  }

   Future updateWallpaperDownload(id) async {
    final String subUrl = "/wallpaper/updatedownload/$id";

    final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);

    try {
      final http.Response response = await client.put(uri, headers: headers);

      final statusCode = response.statusCode;
      final body = response.body;

      if (statusCode == 200) {
        // print(body);
        // SnackbarUtility.showSnackBar(
        //     context: context, message: "Category updated succesfully");
        return body;
      }
    } catch (e) {
      print(e.toString());
    }
  }


}
