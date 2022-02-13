import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/color_model.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/routes/api.routes.dart';

class ColorController extends GetxController {
  static ColorController instance =  Get.put(ColorController());

  final _database = FirebaseDatabase.instance.reference();

  RxList<ColorModel> colorList = RxList([]);

  List<WallpaperData> wallpaperAllList = [];

  final client = http.Client();

  @override
  void onInit() {
  //  colorList.bindStream(getColorList());
    wallpaperAllList.addAll(wallPapaerController.wallpaperList);
    super.onInit();
  }

  
    final headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
     "Connection": "keep-alive",
    "Access-Control-Allow-Origin": "*"
  };

  Future<List<ColorData>> getColorList() async{
    final _colorStream = _database.child("colors").onValue;
    final colorFullList = <String>[];

     final String subUrl = "/color/getcolor";

     final Uri uri = Uri.parse(APIRoutes.BaseURL + subUrl);
    
  

   http.Response response =  await  client.get(uri,headers: headers);

      final statusCode = response.statusCode;
      final body = response.body;

      var colorModel = ColorModel.fromJson(jsonDecode(body));

        var colorStatusCode = colorModel.code;
      var colorData = colorModel.data;

      if (statusCode == 200) {
          print(body);
      }
   

    // final streamColorToPublish = _colorStream.map((event) {
    //   final colorMap = Map<String, dynamic>.from(event.snapshot.value);
    //   final colorList = colorMap.entries.map((element) {
    //     //print("EL ${element.key} and Lenth  ${wallAllList.length}");

    //     colorFullList.add(element.key.toString());

    //     // print(testList.length);

    //     return ColorModel.fromRTDB(Map<String, dynamic>.from(element.value));
    //   }).toList();

    //   return colorList;
    // });

    // catFullList.forEach((element) {
    //  var testList =
    //     wallAllList.firstWhere(((e) => e.getCategory == element.toString()));
    //     print(testList.description);
    // });

    return colorData;
  }

  List<WallpaperData> getWallpaperColor(String colorName) {
   
    return wallpaperAllList
        .where((element){
         // element.colorName;
        
         return   element.colorName.toLowerCase() == colorName.toLowerCase();
        }).toList();
        
  }
}
