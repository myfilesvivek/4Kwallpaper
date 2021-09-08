import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wallpaper_app/constants.dart';

import 'package:wallpaper_app/screens/category_screen.dart';
import 'package:wallpaper_app/screens/colors_wall_screen.dart';
import 'package:wallpaper_app/screens/home_screen.dart';
import 'package:wallpaper_app/screens/liked_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  final screens = [
    HomeScreen(),
     CategoryScreen(),
     ColorsWallScreen(),
   
   
    LikedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (newPage) {
          setState(() {
            this._currentIndex = newPage;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bottom_nav_bg,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              spreadRadius: 0,
              blurRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) {
              this._pageController?.animateToPage(i,
                  duration: Duration(milliseconds: 300), curve: Curves.easeIn,);
            },
            unselectedItemColor: Colors.white,
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(EvaIcons.homeOutline),
                activeIcon: Icon(EvaIcons.home),
                title: Text("Home"),
                selectedColor:pink,
                
                
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(EvaIcons.gridOutline),
                activeIcon: Icon(EvaIcons.grid),
                title: Text("Category"),
                selectedColor: Colors.orange,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(EvaIcons.colorPaletteOutline),
                activeIcon: Icon(EvaIcons.colorPalette),
                title: Text("Color"),
                selectedColor: Colors.teal,
              ),
              //Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                title: Text("Likes"),
                selectedColor: Colors.pink,
              )
            ],
          ),
        ),
      ),
    );
  }
}
