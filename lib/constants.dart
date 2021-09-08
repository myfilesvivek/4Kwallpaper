import 'package:flutter/material.dart';
import 'package:wallpaper_app/controllers/category_controller.dart';
import 'package:wallpaper_app/controllers/color_controller.dart';
import 'package:wallpaper_app/controllers/counter_controller.dart';

import  './controllers/wallpaper_controller.dart';

WallPaperController wallPapaerController = WallPaperController.instance;
CategoryController categoryController = CategoryController.instance;
ColorController colorConroller = ColorController.instance;

CounterCountroller counterCountroller = CounterCountroller.instance;


final Shader linearGradient = LinearGradient(
  colors: <Color>[orange,pink],
).createShader(Rect.fromLTWH(190.0, 0.0, 100.0, 60.0));


const orange = Color(0xfff4674c);

const pink =  Color(0xffec0588);

const darkGreen =  Color(0xff2c9b57);

const lgGreen =  Color(0xffcdf7df);


const scaffold_bg = Color(0xFF000011);

const bottom_nav_bg = Color(0xFF060614);

const cat_bg = Color(0xFF000011);

const String FAV_BOX = "Favorites";
const String FAV_LIST_KEY = "List";
