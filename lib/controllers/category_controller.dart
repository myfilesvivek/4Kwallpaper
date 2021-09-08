import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';

class CategoryController extends GetxController {
 
  static CategoryController instance = Get.find();

  final _database = FirebaseDatabase.instance.reference();

  RxList<CategoryModel> categoryList = RxList<CategoryModel>([]);
  final wallAllList = <WallpaperModel>[];

  @override
  void onInit() {
    categoryList.bindStream(getAllCategory());
    wallAllList.addAll(wallPapaerController.wallpaperList);
    super.onInit();
  }

  Stream<List<CategoryModel>> getAllCategory() {
    final _catStream = _database.child("categories").onValue;
    final catFullList = <String>[];

    final streamToPublish = _catStream.map((event) {
      final wallMap = Map<String, dynamic>.from(event.snapshot.value);
      final wallList = wallMap.entries.map((element) {
      

        catFullList.add(element.key.toString());

       

        return CategoryModel.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();

      return wallList;
    });


    return streamToPublish;
  }

 
}
