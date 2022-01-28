import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/model/category_model.dart';
import 'package:saaty_app/view/screens/main_page_screen.dart';


class CategoryItem extends StatelessWidget {
  CategoryModel model;
int pos;

  CategoryItem(this.model,this.pos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           GestureDetector(
             onTap: (){
               Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE,arguments: pos as int);
             },
             child: Container(
               padding: EdgeInsets.all(8),
               child: Card(
                 elevation: 10,
                 child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                  child:  Image.network(
                      model.image
                     ,
                      height: 60.0,
                      width: 60.0,
                        fit: BoxFit.cover
                    ),
                  ),
               ),
             ),
           ),
         // SizedBox(height: 5,),
          Center(child: Text(model.name,style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.w600,),))
        ],

      ),
    );
  }
}
