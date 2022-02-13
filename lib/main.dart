import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/controllers/wallpaper_controller.dart';

import './screens/myhomepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

import 'controllers/category_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp();
  await _initApp();

  runApp(MyApp());
}

Future<void> _initApp() async {
  var docDir = await getApplicationDocumentsDirectory();

  Hive.init(docDir.path);

  var favBox = await Hive.openBox(FAV_BOX);

  if (favBox.get(FAV_LIST_KEY) == null) {
    favBox.put(FAV_LIST_KEY, <dynamic>[]);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Get.put(WallPaperController());
    Get.put(CategoryController());

    //  print("HM1${wallController.feauredNWallList.length}");
    return GetMaterialApp(
      title: '4K Wallpaper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffold_bg,
        primaryColor: scaffold_bg,
        fontFamily: 'Gilroy',
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        appBarTheme: AppBarTheme(backgroundColor: scaffold_bg)
      ),
      home: MyHomePage(),
    );
  }
}
