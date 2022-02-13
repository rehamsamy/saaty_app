import 'package:flutter/material.dart';

import '../../cons.dart';
import 'CategoryItem.dart';

class CategoryListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return    Container(
      height: 150,
      child: ListView.builder(
        itemBuilder: (_, inx) =>
            CategoryItem(Cons.categoriesList[inx], inx),
        itemCount: Cons.categoriesList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
