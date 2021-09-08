import 'package:flutter/material.dart';


class ColorItem extends StatelessWidget {
  final Color? color;
  final Function()? onClick;
  final selectedIndex;
  final index;
  final showTick;
  ColorItem(
      {@required this.color,
      this.onClick,
      this.selectedIndex,
      this.index,
      this.showTick = false});

 // final _colorData = ColorModel.colorList();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 20,
        width: 20,
        child: Container(
          child: Center(
            child: showTick == true
                ? selectedIndex == index
                    ? Icon(
                        Icons.done,
                        color:Colors.white
                          //  _colorData[selectedIndex].colorCode == Colors.black
                              //  ? Colors.white
                             //   : Colors.black,
                      )
                    : Container()
                : Container(),
          ),
        ),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade100.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: color!.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
      ),
    );
  }
}
