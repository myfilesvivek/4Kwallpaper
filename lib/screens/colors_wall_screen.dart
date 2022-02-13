import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/color_model.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/color_item.dart';
import 'package:wallpaper_app/widgets/wallpaper_container.dart';

class ColorsWallScreen extends StatefulWidget {
  @override
  _ColorsWallScreenState createState() => _ColorsWallScreenState();
}

class _ColorsWallScreenState extends State<ColorsWallScreen> {
  var colorsWallpaperData = <WallpaperData>[];

  // List<ColorData>? colorsList;

  String? colortop;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<ColorData>>(
          future: colorConroller.getColorList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(pink),
                ),
              );
            }

            final colModelList = <ColorData>[];

            final myColors = snapshot.data as List<ColorData>;

            colModelList.addAll(myColors.map(
                (e) => ColorData(e.id, e.colorCode, e.colorName, e.priority)));

            colortop =
                colModelList[_selectedIndex].colorCode.replaceAll('#', '0xff');

            colorsWallpaperData.clear();
            colorsWallpaperData.addAll(colorConroller
                .getWallpaperColor(
                    colModelList[_selectedIndex].colorName.toString())
                .reversed
                .toList());

            // colorConroller.getColorList().then((value) {
            //   setState(() {
            //     colorsList = value;
            //     colortop = colorsList![_selectedIndex]
            //         .colorCode
            //         .replaceAll('#', '0xff');
            //   });

            //   colorsData.clear();

            //   colorsData.addAll(colorConroller
            //       .getWallpaperColor(
            //           colorsList![_selectedIndex].colorName.toString())
            //       .reversed
            //       .toList());
            // });
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ColorItem(
                          color: Color(int.parse(colortop!)),
                          showTick: false,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${myColors[_selectedIndex].colorName.toString()}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ExpansionTile(
                              iconColor: Colors.purpleAccent.shade100,
                              collapsedIconColor: Colors.white,
                              collapsedTextColor: Colors.white,
                              textColor: Colors.purpleAccent.shade100,
                              collapsedBackgroundColor: scaffold_bg,
                              backgroundColor: Colors.grey.shade900,
                              title: Text(
                                "Filter by:  Color",
                                style: TextStyle(fontSize: 15),
                              ),
                              children: [
                                SizedBox(
                                  height: 110,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                      padding: EdgeInsets.all(10),
                                      itemCount: myColors.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              // childAspectRatio: (0.3 / 0.3),
                                              crossAxisCount: 9,
                                              mainAxisSpacing: 9,
                                              crossAxisSpacing: 9),
                                      itemBuilder: (context, index) {
                                        String color = myColors[index]
                                            .colorCode
                                            .replaceAll('#', '0xff');
                                        return ColorItem(
                                          showTick: true,
                                          color: Color(int.parse(color)),
                                          onClick: () {
                                            setState(() {
                                              _selectedIndex = index;
                                            });
                                          },
                                          selectedIndex: _selectedIndex,
                                          index: index,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: colorsWallpaperData.isNotEmpty
                          ? GridView.builder(
                              itemCount: colorsWallpaperData.length,
                              padding:
                                  EdgeInsets.only(top: 10, left: 5, right: 5),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).orientation ==
                                            Orientation.landscape
                                        ? 4
                                        : 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: (1 / 2),
                              ),
                              itemBuilder: (context, index) =>
                                  WallpaperContainer(
                                    wallpaperModelMain:
                                        colorsWallpaperData[index],
                                  ))
                          : Center(
                              child: Text("No wallpaper found"),
                            ),
                    ),
                  ],
                ));
          }),
    );
  }
}
