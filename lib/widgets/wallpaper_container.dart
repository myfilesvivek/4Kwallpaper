import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:progressive_image/progressive_image.dart';

import 'package:wallpaper_app/models/wallpaper_model.dart';

import 'package:wallpaper_app/screens/view_wallpaper_screen.dart';

class WallpaperContainer extends StatefulWidget {
  final WallpaperModel wallpaperModelMain;
  

  WallpaperContainer({required this.wallpaperModelMain});

  @override
  State<WallpaperContainer> createState() => _WallpaperContainerState();
}

class _WallpaperContainerState extends State<WallpaperContainer> {
   Image? myImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      myImage= Image.network(widget.wallpaperModelMain.getImageURLLow
      ,filterQuality: FilterQuality.low
      ,fit: BoxFit.cover,
       );
     
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
     precacheImage(myImage!.image, context);
  }
  @override
  Widget build(BuildContext context) {
  
    return InkWell(
      onTap: () {
        // Get.to(() => ViewWallpaperScreen(wallpaperModel: wallpaperModelMain));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ViewWallpaperScreen(wallpaperModel: widget.wallpaperModelMain)),
        );

        // adMobService.interstitialAdLoad();

        // print(HomeScreen.counter);
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:myImage
          
          //  ProgressiveImage(
          //     fit: BoxFit.cover,
          //     placeholder: AssetImage('assets/gif/loading_ligth.gif'),
          //     blur: 5.0,
          //     // size: 1.87KB
          //     thumbnail: NetworkImage(wallpaperModelMain.imageURLLow!),
          //     // size: 1.29MB
          //     image: NetworkImage(wallpaperModelMain.getImgUrl),
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height),

        ),
      ),
    );
  }
}
