import 'package:flutter/material.dart';

class ViewWallpaerBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
