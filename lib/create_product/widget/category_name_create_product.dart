import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cons.dart';
class CategoryName extends StatefulWidget {
  const CategoryName({Key key}) : super(key: key);

  @override
  _CategoryNameState createState() => _CategoryNameState();
}

class _CategoryNameState extends State<CategoryName> {
  int _radValCat=0;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState)=>
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('category'.tr),
              SizedBox(width: 30,),
              Radio(value: 0, groupValue: _radValCat, onChanged: (value){
                setState(() {
                  print(value);
                  _radValCat=value;
                });
              },
                hoverColor: Cons.primary_color,
                materialTapTargetSize: MaterialTapTargetSize.padded, activeColor:Cons.primary_color ,),
              Text('watch'.tr),
              Radio(value: 1, groupValue: _radValCat, onChanged: (value){
                setState(() {
                  _radValCat=value;
                });
              },
                materialTapTargetSize: MaterialTapTargetSize.padded, activeColor:Cons.primary_color ,),
              Text('braclete'.tr),

            ],
          ),
    );
  }
}
