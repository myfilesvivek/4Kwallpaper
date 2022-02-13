import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryItem extends StatelessWidget {
  final imageUrl;
  final categoryName;
 // final int totalWallpaerNumber;

  CategoryItem(
      {this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    var totalCatWallpaper = wallPapaerController.wallpaperList.where((element) => element.category == categoryName).toList().length;
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: cat_bg,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 9,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3.5, horizontal: 3.5),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                )

                // ProgressiveImage(
                //     fit: BoxFit.cover,
                //     placeholder: AssetImage('assets/gif/shimmereffect.gif'),
                //     // size: 1.87KB
                //     thumbnail: NetworkImage(imageUrl),
                //     // size: 1.29MB
                //     image: NetworkImage(imageUrl),
                //     width: 60,
                //     height: 60),

                // CachedNetworkImage(
                //   placeholder: (context,url)=> Image.asset('assets/gif/shimmereffect.gif',fit: BoxFit.cover,),
                //   imageUrl:  imageUrl,
                //   width: 60,
                //   height: 60,
                //   fit: BoxFit.cover,
                // ),
                ),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(categoryName),
              SizedBox(
                height: 6,
              ),
              Text(
                totalCatWallpaper.toString(),
                style: TextStyle(fontSize: 10, color: Colors.grey.shade200),
              )
            ],
          )
        ],
      ),
    );
  }
}
