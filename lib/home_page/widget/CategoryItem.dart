import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/model/category_model.dart';
import 'package:saaty_app/main_page/screen/main_page_screen.dart';
import 'package:saaty_app/view/widget/app_cashed_image.dart';


class CategoryItem extends StatelessWidget {
  CategoryModel model;
int pos;

  CategoryItem(this.model,this.pos);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Flexible(
           fit: FlexFit.loose,
           child: GestureDetector(
             onTap: (){
               Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE,arguments: pos as int);
             },
             child: Container(
               padding: EdgeInsets.all(8),
               child: Card(
                 elevation: 10,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20.0)
                 ),
                 child:AppCashedImage(imageUrl: model.image,width: 90,height: 90,),
               ),
             ),
           ),
         ),
       // SizedBox(height: 5,),
        Center(child: Text(model.name,style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600,),))
      ],

    );
  }
}
