import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:wallpaper_app/widgets/wallpaper_container.dart';

import '../constants.dart';

class LikedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  List<WallpaperModel> likedWallpaper = [];

    //     likedWallpaper
    //       .addAll(wallPapaerController.likedListItems.value);
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked Wallpapers"),
      ),
      body: Obx(() => wallPapaerController.likedListItems.isNotEmpty
          ? GridView.builder(
              itemCount: wallPapaerController.likedListItems.length,
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
                    wallpaperModelMain:
                        wallPapaerController.likedListItems[index],
                  ))
          : Center(
              child: Text("No wallpaper found"),
            )),
    );
  }
}
