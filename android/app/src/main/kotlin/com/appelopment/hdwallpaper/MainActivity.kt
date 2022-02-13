package com.appelopment.hdwallpaper

import io.flutter.embedding.android.FlutterActivity

import android.os.Bundle



// private const val CHANNEL = "com.appelopment.hdwallpaper/wallpapers"


class MainActivity: FlutterActivity() {



}

//  override fun onCreate(savedInstanceState: Bundle?) {
//      super.onCreate(savedInstanceState)
//      GeneratedPluginRegistrant.registerWith(this)
//
//      MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
//          if (call.method == "setWallpaper") {
//              val arguments = call.arguments as ArrayList<*>
//              val setWallpaper = setWallpaper(arguments[0] as String, applicationContext, arguments[1] as Int)
//
//              if (setWallpaper == 0) {
//                  result.success(setWallpaper)
//              } else {
//                  result.error("UNAVAILABLE", "", null)
//              }
//          } else {
//              result.notImplemented()
//          }
//      }
////}
//  }
    //   @TargetApi(24)
    //   private fun setWallpaper(path: String, applicationContext: Context, wallpaperType: Int): Int {
    //       var setWallpaper = 1
    //       val bitmap = BitmapFactory.decodeFile(path)
    //       val wm: WallpaperManager? = WallpaperManager.getInstance(applicationContext)
    //       setWallpaper = try {
    //           wm?.setBitmap(bitmap, null, true, wallpaperType)
    //           0
    //       } catch (e: IOException) {
    //           1
    //       }

    //       return setWallpaper
    //   }

  //}

 