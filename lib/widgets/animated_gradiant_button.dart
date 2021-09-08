import 'package:flutter/material.dart';

class AnimatedGradient extends StatefulWidget {
  final Function onClicked;

  AnimatedGradient(this.onClicked);

  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  List<Color> colorList = [
    Color(0xff338ee3),
    Color(0xFF0055D5),
   // Color(0xFF00DF82),
    Color(0xff45e8a4),
  ];
  List<Alignment> alignmentList = [
    Alignment.topCenter,
    Alignment.bottomCenter,
  ];
  int index = 0;
  Color bottomColor = Color(0xff338ee3);
  Color topColor = Color(0xff45e8a4);
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    playGradiantAnim();
    // playOnEndAnim();
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onClicked(),
          child: AnimatedContainer(
            height: 55,
            width: 55,
            padding: EdgeInsets.all(15),
            duration: Duration(milliseconds: 500),
            child: Image.asset(
              'assets/images/download-arrow.png',
              height: 35,
              width: 35,
              color: Colors.white,
            ),
            onEnd: playOnEndAnim,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: begin, end: end, colors: [topColor, bottomColor])),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Downloading...",
          style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'MuseoSans',
              fontWeight: FontWeight.w500),
        )
      ],
    );
    //     Positioned.fill(
    //       child: IconButton(
    //         icon: Icon(Icons.play_arrow),
    //         onPressed: ()=>playGradiantAnim(),

    //       ),
    //     )
    //   ],
    // );
  }

  void playOnEndAnim() {
    setState(() {
      index = index + 1;
      // animate the color
      bottomColor = colorList[index % colorList.length];
      topColor = colorList[(index + 1) % colorList.length];

      //// animate the alignment
      // begin = alignmentList[index % alignmentList.length];
      // end = alignmentList[(index + 2) % alignmentList.length];
    });
  }

  void playGradiantAnim() {
    return setState(() {
      bottomColor = Colors.blue;
    });
  }
}
