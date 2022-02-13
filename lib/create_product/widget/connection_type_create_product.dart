import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cons.dart';
class ConnectionType extends StatefulWidget {

  @override
  _ConnectionTypeState createState() => _ConnectionTypeState();
}

class _ConnectionTypeState extends State<ConnectionType> {
  int _radValContact=0;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState)=>
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 0, groupValue: _radValContact, onChanged: (value){
                    setState(() {print('nnnnnnnnnnnn');}) ;
                    setState(() {
                      _radValContact=value;
                    });
                  },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor:Cons.primary_color ,),
                  Container(
                      width: 50,child: Text('phone'.tr)),
                  // SizedBox(width: 10,),
                  Radio(value: 1, groupValue: _radValContact, onChanged: (value){
                    setState(() {
                      _radValContact=value;
                    });
                  },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor:Cons.primary_color ,),
                  Container(width:55,child: Text('email'.tr,)),
                  //SizedBox(width: 10,),
                  Radio(value: 2, groupValue: _radValContact, onChanged: (value){
                    setState(() {
                      _radValContact=value;
                    });
                  },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor:Cons.primary_color ,),
                  Container(width:50,child: Text('private_messages'.tr)),
                  // SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 3, groupValue: _radValContact, onChanged: (value){
                    setState(() {
                      _radValContact=value;
                    });
                  },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    activeColor:Cons.primary_color ,
                  ),
                  Text('all'.tr),
                ],
              ),


            ],
          ),
    );

  }
}
