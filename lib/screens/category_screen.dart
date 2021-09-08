import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/screens/category_wallpaper_screen.dart';
import 'package:wallpaper_app/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "All Category",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: StreamBuilder<Object>(
          stream: categoryController.getAllCategory(),
          builder: (context, snapshot) {
             final catModelLIst =   <CategoryModel>[];
                if(snapshot.hasData){
                  final myCategories = snapshot.data as List<CategoryModel>;

                  catModelLIst.addAll(myCategories.map((e) {
                    return CategoryModel(
                      e.categoryName,
                      e.categoryImageUrl,
                      e.categoryPriority,
                      e.totalWallpapers
                    );
                  }),
                  );
                }

            return GridView.builder(
            
                itemCount: catModelLIst.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.landscape
                          ? 3
                          : 2,
                  // crossAxisSpacing: 8,
                  // mainAxisSpacing: 8,
                  childAspectRatio: (2.6 / 1),
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                   // print(catModelLIst[index].categoryName);
                    Get.to(()=>CategoryWallpaperScreen(),arguments: catModelLIst[index].categoryName);
                  },
                  child: CategoryItem(
                    imageUrl:catModelLIst[index].categoryImageUrl ,
                    categoryName: catModelLIst[index].categoryName ,
                    totalWallpaerNumber:catModelLIst[index].totalWallpapers ,
                  ),
                ));
          }
        ));
  }
}
