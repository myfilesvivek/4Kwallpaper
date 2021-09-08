

import 'package:get/get.dart';

class CounterCountroller extends GetxController{

   static CounterCountroller instance = Get.put(CounterCountroller());

  var counter = 0.obs;

  


  void increaseCounter(){

    counter++;

 //   print(counter);
  }

  void resetCounter(){

    counter.value = 0;
  }

}