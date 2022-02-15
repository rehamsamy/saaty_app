import 'package:flutter/material.dart';

import '../../cons.dart';
import 'CategoryItem.dart';

class CategoryListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   Stack(
      children: [
        Container(
          height: 180,
          child: Center(child: Image.asset('assets/images/home_photo.png',fit: BoxFit.contain,),),),
         Container(
        height: 150,
        child: ListView.builder(
          itemBuilder: (_, inx) =>
              CategoryItem(Cons.categoriesList[inx], inx),
          itemCount: Cons.categoriesList.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
      ],
    );
  }
}
