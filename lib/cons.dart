import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/lang_controller.dart';

import 'model/category_model.dart';
import 'model/product_model.dart';

class Cons {
  static Color primary_color=Colors.white;
  static Color accent_color=Colors.white;
  static LangController _langController=Get.find();

  static var whiteFont=TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold );
  static var blackFont=TextStyle(color: Colors.black,fontSize: 15,fontStyle: FontStyle.italic);
  static var greyFont=TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold);
  static var accentFont=TextStyle(color: Color.fromARGB(255,213,177,57),fontSize: 20,fontWeight: FontWeight.bold);
  static var blueFont=TextStyle(color: Color.fromARGB(255,123,196,229),fontSize: 20,fontWeight: FontWeight.bold);
  static var greyFont1=TextStyle(color: Colors.black54,fontSize: 18);
  static var greenFont= TextStyle(color: Colors.lightGreen);
 static var blackStyle1= TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  );




 static void buildColors(BuildContext ctx){
   primary_color=Theme.of(ctx).primaryColor;
   accent_color=Theme.of(ctx).accentColor;
 }
//static Widget getAppbar(String title);


 static List<Product> selectionAsecSortFilter(List<Product> prodss) {
   List<Product> prods=prodss ;
   print('&&&&&&&&&&&');
   print(prods.length);
   for (var i = 0; i < prods.length - 1; i++) {
     var index_min = i;
     for (var j = i + 1; j < prods.length; j++) {
       if (double.parse(prods[j].price) <
           double.parse(prods[index_min].price)) {
         index_min = j;
       }
     }
     if (index_min != i) {
       var temp = prods[i];
       prods[i] = prods[index_min];
       prods[index_min] = temp;
     }
   }
   print(prods.length);
   return prods;
 }


    static List<Product> selectionDescSortFilter(List<Product> prods) {
      List<Product> newWishlist=[];
      for (var i = 0; i < prods.length - 1; i++) {
        var index_min = i;
        for (var j = i + 1; j < prods.length; j++) {
          if (double.parse(prods[j].price) > double.parse(prods[index_min].price)) {
            index_min = j;
          }
        }
        if (index_min != i) {
          var temp = prods[i];
          prods[i] = prods[index_min];
          prods[index_min] = temp;
        }
      }

   return prods;

  }


  static String getText(String x){
    print('vvvvvv  '+_langController.isEn.toString());
    return  _langController.isEn?_langController.getEnText[x]:_langController.getArText[x];
  }
  static List<CategoryModel> categoriesList = [
    new CategoryModel(  'https://mediaaws.almasryalyoum.com/news/large/2021/03/13/1486052_0.jpg', 'all'.tr),
    new CategoryModel('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgBE25ULYTVSc5bJGSuJlohY6bkmA99UzDYtympbebiCpnXhHlnqZUrQAbdxtdzvVZ67Q&usqp=CAU', 'watches'.tr),
    new CategoryModel('https://www.aljamila.com/sites/default/files/styles/1100x732/public/2019/02/27/2550806-1516587346.jpg', 'bracletes'.tr),
    new CategoryModel( 'https://www.almaal.org/wp-content/uploads/2020/02/%D9%83%D9%8A%D9%81-%D8%AA%D8%A8%D8%AF%D8%A3-%D8%A7%D9%84%D8%A7%D8%B3%D8%AA%D8%AB%D9%85%D8%A7%D8%B1-%D8%A7%D9%84%D8%B9%D9%82%D8%A7%D8%B1%D9%8A-%D8%A8%D8%B1%D8%A3%D8%B3-%D9%85%D8%A7%D9%84-%D8%B5%D8%BA%D9%8A%D8%B1-2021-%D9%83%D9%8A%D9%81-%D8%AA%D8%A8%D8%AF%D8%A3-%D8%A7%D9%84%D8%A7%D8%B3%D8%AA%D8%AB%D9%85%D8%A7%D8%B1-%D8%A7%D9%84%D8%B9%D9%82%D8%A7%D8%B1%D9%8A-%D8%A8%D8%B1%D8%A3%D8%B3-%D9%85%D8%A7%D9%84-%D8%B5%D8%BA%D9%8A%D8%B1-2021-2.jpg'
        , 'stores'.tr),

  ];


}