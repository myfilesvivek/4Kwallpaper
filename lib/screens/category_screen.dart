import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/controllers/category_controller.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/screens/category_wallpaper_screen.dart';
import 'package:wallpaper_app/widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
   // CategoryController categoryController = CategoryController.instance;
  //  final CategoryController categoryController = Get.put(CategoryController());
   
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "All Category",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: FutureBuilder(
          future: categoryController.getAllCategory(),
          builder: (context, snapshot) {
           
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(pink),),);
            }

            
           
                if(!snapshot.hasData){
                     return Center(child: Text('error no data'));
                }
                 if(snapshot.hasError){
                     return Text('error');
                }
                  
                  //  final catModelLIst =   <CategoryData>[];
                 

                  // catModelLIst.addAll(myCategories.map((e) {
                  //   return CategoryData(
                  //     e.id,
                  //     e.categoryName,
                  //      e.desc,
                  //     e.priority,
                  //     e.thumbnail,
                  //     e.totalWallpapers,
                     
                     
                    
                      
                  //   );
                  // }),
                  // );

                   final myCategories = snapshot.data as List<CategoryData>;
                
                 // print(myCategories.);

            return GridView.builder(
            
                itemCount: myCategories.length,
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
                    Get.to(()=>CategoryWallpaperScreen(),arguments: myCategories[index].categoryName);
                  },
                  child: CategoryItem(
                    imageUrl:myCategories[index].thumbnail ,
                    categoryName: myCategories[index].categoryName ,
                   
                  ),
                ));
                
             
          
         
          }
        ));
  }
}
