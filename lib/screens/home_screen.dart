

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:wallpaper_app/constants.dart';

import 'package:wallpaper_app/models/wallpaper_model.dart';

import 'package:wallpaper_app/screens/wallpaper_type_screen.dart';
import 'package:wallpaper_app/utils/wallpaper_search.dart';

import 'package:wallpaper_app/widgets/search_bar.dart';
import 'package:wallpaper_app/widgets/wallpaper_container.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
   var _firebaseRef;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   
    @override
    void initState() { 
      super.initState();
   widget._firebaseRef     =
        FirebaseDatabase().reference().child('homescreenimage');
    }


    @override
    void didUpdateWidget (HomeScreen oldWidget) {
      super.didUpdateWidget(oldWidget);

      if(oldWidget._firebaseRef != widget._firebaseRef){

        widget._firebaseRef     =
        FirebaseDatabase().reference().child('homescreenimage');
      }
      
    }




  Widget build(BuildContext context) {
  
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: wallPapaerController.getAllWallPaper(),
          builder: (context, snapshot) {
            //  final wallAllList = <WallpaperModel>[];

            if (snapshot.hasData) {
              // final mywall = snapshot.data as List<WallpaperModel>;
              //   wallAllList.addAll(wallPapaerController.popularWallList);
             
            } else {
              Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  stretch: true,
                  title: Text(
                    "4K Wallpaper",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Monarda",
                      foreground: Paint()..shader = linearGradient,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                        ),
                        Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(125, 0, 0, 255).withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    title: SearchBar(onPressed: () {
                      showSearch(context: context, delegate: WallPaperSearch());
                      // print('Hello Working');
                    }),
                    centerTitle: true,
                    background: DecoratedBox(
                      position: DecorationPosition.foreground,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [scaffold_bg, Colors.transparent])),
                      child: FutureBuilder<Object>(
                          future: widget._firebaseRef.once(),
                          builder: (context, snap) {
                            dynamic url;
                            dynamic urlLow;
                            if (snap.hasData) {
                              // final mywall = snapshot.data as List<WallpaperModel>;
                              final myHomeWall = Map<String, dynamic>.from(
                                  (snap.data! as DataSnapshot).value);

                              url = myHomeWall["url"];
                              urlLow = myHomeWall["url_low"];
                            } else {
                              return Container();
                            }
                            return ProgressiveImage(
                                blur: 10.0,
                                fit: BoxFit.cover,
                                placeholder:
                                    AssetImage('assets/gif/shimmereffect.gif'),

                                // size: 1.87KB
                                thumbnail: NetworkImage(urlLow),
                                // size: 1.29MB
                                image: NetworkImage(url),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height);
                          }),
                    ),
                  ),
                ),
                CustomRow(
                  "Popular now",
                  onPressed: () {
                    //  Get.snackbar( "Popular","");

                    Get.to(() => WallpaperTypeScreen(), arguments: "Popular");
                  },
                ),
                HomeHorizonalScrollView(wallPapaerController.popularWallList),
                CustomRow(
                  "Trending now",
                  onPressed: () {
                    Get.to(() => WallpaperTypeScreen(), arguments: "Trending");
                  },
                ),
                HomeHorizonalScrollView(wallPapaerController.trendingWallList),
                CustomRow(
                  "Featured now",
                  onPressed: () {
                    Get.to(() => WallpaperTypeScreen(), arguments: "Featured");
                  },
                ),
                HomeHorizonalScrollView(wallPapaerController.feauredNWallList),
              ],
            );
          }),
    );
  }
}

class HomeHorizonalScrollView extends StatelessWidget {
  final List<WallpaperModel> _wapperModelTypeList;

  HomeHorizonalScrollView(this._wapperModelTypeList);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 250.0,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 3,
                width: 10,
              );
            },
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: _wapperModelTypeList.length > 6
                ? 6
                : _wapperModelTypeList.length,
            itemBuilder: (context, index) => WallpaperContainer(
                wallpaperModelMain: _wapperModelTypeList[index])),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final title;
  final VoidCallback onPressed;
  CustomRow(this.title, {required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w800),
                ),
                Text('View all',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w400)),
              ]),
        ),
      ),
    );
  }
}




