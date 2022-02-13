import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cons.dart';

class ProductType extends StatefulWidget {
  const ProductType({Key key}) : super(key: key);

  @override
  _ProductTypeState createState() => _ProductTypeState();
}

class _ProductTypeState extends State<ProductType> {
  int _radValType=0;
  int _radValContact=0;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState)=>
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('status'.tr),
                SizedBox(width: 30,),
                Radio(value: 0, groupValue: _radValType, onChanged: (value){
                  setState(() {
                    print('vvvvvvvvvvvvvvvv 1  $value');
                    _radValType=value;
                    print('vvvvvvvvvvvvvvvv 1 $_radValType');
                  });
                },
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  activeColor:Cons.primary_color ,),
                Container(width:50,child: Text('old'.tr)),
                Radio(value: 1, groupValue: _radValType, onChanged: (value){
                  setState(() {
                    print(value);
                    _radValType=value;
                  });
                },
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  activeColor:Cons.primary_color ,),
                Container(width:50,child: Text('new'.tr)),

              ],
            )
    );
  }
}
