import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/wallpaper_container.dart';

import '../constants.dart';

class WallPaperSearch extends SearchDelegate<String> {
  
  
  final cities = wallPapaerController.suggList;
  


  final recentCities = wallPapaerController.suggList.take(5);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {

       List<WallpaperModel> categoryWallpaper = [];
  

    categoryWallpaper
        .addAll(wallPapaerController.getListFromSearch(query).reversed);
    return  categoryWallpaper.isNotEmpty
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
            );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.black,
      
      scaffoldBackgroundColor: scaffold_bg,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold_bg,
        
      
      ),
      hintColor: Colors.white,
      textTheme:  TextTheme(headline6: TextStyle( color: Colors.white, fontSize: 18,),),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    final suggestionList = [];
    suggestionList.addAll(  query.isEmpty
        ? recentCities
        : cities
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList());

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index]; 
          showResults(context);
        },
        leading: Icon(
          Icons.image,
          color: Colors.white,
        ),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
