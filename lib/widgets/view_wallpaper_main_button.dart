import 'package:flutter/material.dart';

class ViewWallpaerMainButton extends StatelessWidget {
  final String? icon;
  final String? text;
  final Color? color;
  final bool showGrad;
  final Color? iconColor;
  final double width;
  final double hight;
  final double padding;

  ViewWallpaerMainButton(
      {@required this.icon,
      @required this.text,
      this.color,
      this.showGrad = false,this.iconColor,this.width =35,this.hight = 35,this.padding =10});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
              color: this.color ?? Colors.white,
              shape: BoxShape.circle,
              gradient: showGrad
                  ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                          Color(0xfff82973),
                          Color(0xfff82973),
                          Color(0xfff75fcd)
                        ])
                  : null,
              boxShadow: showGrad? [
                BoxShadow(
                  color:  Color(0xfff75fcd).withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 10,
                ),
                BoxShadow(
                  color: Color(0xfff75fcd).withOpacity(0.5),
                  spreadRadius: -4,
                  blurRadius: 5,
                )
              ]: null),
          child: Image.asset(
            icon!,
            height: hight,
            width: width,
            color: iconColor,
           
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          text!,
          style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'MuseoSans',fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
