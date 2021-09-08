import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/wallpaper_container.dart';

class CategoryWallpaperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<WallpaperModel> categoryWallpaper = [];
    var categoryName = Get.arguments;

    categoryWallpaper
        .addAll(wallPapaerController.getListFromCategories(categoryName).reversed);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: categoryWallpaper.isNotEmpty
          ? GridView.builder(
              itemCount: categoryWallpaper.length,
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
                    wallpaperModelMain: categoryWallpaper[index],
                  ))
          : Center(
              child: Text("No wallpaper found"),
            ),
    );
  }
}
