import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:wallpaper_app/models/wallpaper_model.dart';


import '../constants.dart';

class WallPaperController extends GetxController {
  static WallPaperController instance = Get.find();

  RxList<WallpaperModel> wallpaperList = RxList<WallpaperModel>([]);
  var popularWallList = <WallpaperModel>[];
  var trendingWallList = <WallpaperModel>[];
  var feauredNWallList = <WallpaperModel>[];

   var suggestionList = <String>[];

  // String homescreenimage ="";
  // String homescreenimageLow = "";
  //final favWallList = <WallpaperModel>[].obs;

  var favWallpaperManager;

  // List<WallpaperModel> get wallAll => wallpaperList.value;

  final _database = FirebaseDatabase.instance.reference();


  @override
  void onInit() {
  

    wallpaperList.bindStream(getAllWallPaper());


    super.onInit();
  }

  Stream<List<WallpaperModel>> getAllWallPaper() {
    
    final _wallStream = _database.child("images").onValue;

    final streamToPublish = _wallStream.map((event) {
      final wallMap = Map<String, dynamic>.from(event.snapshot.value);

      final wallList = wallMap.entries.map((element) {
        var wallpaper = WallpaperModel.fromRTDB(
            Map<String, dynamic>.from(element.value), element.key);

        if (isFavorite(wallpaper)) {
          wallpaper.isFavorite.value = true;
        }

        return wallpaper;
      }).toList();

        List<String>? mySugg = [];

      wallpaperList.forEach((element) {
       

        mySugg.add(element.title!);
          mySugg.add(element.description!);
        
      });

      suggestionList = mySugg.toSet().toList().reversed.toList();

    
      popularWallList = wallpaperList
          .where((c) => c.wallpaperType == "Popular")
          .toList()
          .reversed
          .toList();

      trendingWallList = wallpaperList
          .where((c) => c.wallpaperType == "Trending")
          .toList()
          .reversed
          .toList();

      feauredNWallList = wallpaperList
          .where((c) => c.wallpaperType == "Featured")
          .toList()
          .reversed
          .toList();

      //   favWallList.value =
      // wallpaperList.where((c) => c.isFavorite).toList();

      return wallList;
    });

    return streamToPublish;

    
  }

  // void closeStream(){
  //   wallpaperList.close();
  // }

  bool isFavorite(WallpaperModel wallpaper) {
    return Hive.box(FAV_BOX).get(FAV_LIST_KEY).contains(wallpaper.id);
  }

  RxList<WallpaperModel> get likedListItems {
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

  List<WallpaperModel> getListFromCategories(String categoryName) {
    return wallpaperList
        .where((e) => e.category!.toLowerCase() == categoryName.toLowerCase())
        .toList();
  }

   List<WallpaperModel> getListFromSearch(String searchName) {
    return wallpaperList
        .where((e) => e.title!.toLowerCase() == searchName.toLowerCase() ||  e.description!.toLowerCase() == searchName.toLowerCase())
        .toList();
  }

  List<WallpaperModel> getListForType(String typeName) {
    return wallpaperList
        .where((e) => e.wallpaperType!.toLowerCase() == typeName.toLowerCase())
        .toList();
  }
}
