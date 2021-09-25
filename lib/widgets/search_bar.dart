import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants.dart';

class SearchBar extends StatelessWidget {
  final List<Color> _colors = [orange,pink];
  final  List<double> _stops = [0.0, 0.7];
  final Function()? onPressed;
  SearchBar({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(top: 20, right: 23, left: 23, bottom: 30),
        height: 35,
        width: 350,
        decoration: BoxDecoration(
          color: bottom_nav_bg,
          borderRadius: BorderRadius.circular(65),
         
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Search here...',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 10),
              ),
            ),
            Container(
              height: 52,
              width: 32,
              decoration: BoxDecoration(
              
                borderRadius: BorderRadius.circular(55),
                 gradient: LinearGradient(colors: _colors,stops: _stops),
              ),
              child: Icon(
                EvaIcons.searchOutline,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
