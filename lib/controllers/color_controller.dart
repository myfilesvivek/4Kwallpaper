import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/color_model.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';

class ColorController extends GetxController {
  static ColorController instance =  Get.put(ColorController());

  final _database = FirebaseDatabase.instance.reference();

  RxList<ColorModel> colorList = RxList([]);

  List<WallpaperModel> wallpaperAllList = [];

  @override
  void onInit() {
    colorList.bindStream(getColorList());
    wallpaperAllList.addAll(wallPapaerController.wallpaperList);
    super.onInit();
  }

  Stream<List<ColorModel>> getColorList() {
    final _colorStream = _database.child("colors").onValue;
    final colorFullList = <String>[];

    final streamColorToPublish = _colorStream.map((event) {
      final colorMap = Map<String, dynamic>.from(event.snapshot.value);
      final colorList = colorMap.entries.map((element) {
        //print("EL ${element.key} and Lenth  ${wallAllList.length}");

        colorFullList.add(element.key.toString());

        // print(testList.length);

        return ColorModel.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();

      return colorList;
    });

    // catFullList.forEach((element) {
    //  var testList =
    //     wallAllList.firstWhere(((e) => e.getCategory == element.toString()));
    //     print(testList.description);
    // });

    return streamColorToPublish;
  }

  List<WallpaperModel> getWallpaperColor(String colorName) {
   
    return wallpaperAllList
        .where((element){
        
         return element.getColorName == colorName;
        }).toList();
        
  }
}
