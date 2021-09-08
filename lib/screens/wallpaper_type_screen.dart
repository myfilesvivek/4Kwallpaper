import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/wallpaper_container.dart';

class WallpaperTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var typeWallpeprList = <WallpaperModel>[];
    var typeName = Get.arguments;

    typeWallpeprList.addAll(wallPapaerController.getListForType(typeName).reversed);



    return Scaffold(
      appBar: AppBar(
        title: Text(typeName),
      ),
      body: typeWallpeprList.isNotEmpty
          ? GridView.builder(
              itemCount: typeWallpeprList.length,
              padding: EdgeInsets.only(top: 10, left: 5, right: 5),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 4
                        : 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: (1 / 2),
              ),
              itemBuilder: (context, index) => WallpaperContainer(
                    wallpaperModelMain: typeWallpeprList[index],
                  ))
          : Center(
              child: Text("No wallpaper found"),
            ),
    );
  }
}
