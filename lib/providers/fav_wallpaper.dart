

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';

class FavWallpaperManager extends GetxController{

void addToFav(WallpaperModel wallpaper){

  var list =  Hive.box(FAV_BOX).get(FAV_LIST_KEY);

  if(!list.contains(wallpaper.id)){


      list.add(wallpaper.id);
       Hive.box(FAV_BOX).put(FAV_LIST_KEY,list);

       update();
  }

}

void removeFromFav(WallpaperModel wallpaper){
   


  var list =  Hive.box(FAV_BOX).get(FAV_LIST_KEY);

  if(list.remove(wallpaper.id)){

       Hive.box(FAV_BOX).put(FAV_LIST_KEY,list);

      update();
  }
}


bool isFavorite(WallpaperModel wallpaper){

 

  return Hive.box(FAV_BOX).get(FAV_LIST_KEY).contains(wallpaper.id);
}


}