import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/products_controller.dart';

import '../../cons.dart';
import 'main_page_screen.dart';

class StoresScreen extends StatelessWidget {
  static String Stores_SCREEN_ROUTE='/10';
  var _searcController = TextEditingController();
  ProductsController _productController = Get.find();
  FocusNode _textFocus = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomScrollView(
       slivers: [
         SliverAppBar(
           expandedHeight: MediaQuery.of(context).size.height*0.4,
           pinned: true,
           floating: true,
           centerTitle: true,
           automaticallyImplyLeading: false,
           flexibleSpace:Column(
             children: [
              Expanded(flex:1,child: FlexibleSpaceBar(
                title: Text('Name1'),
                centerTitle: true,
              )),
               Expanded(flex:1,child:
                   Card(
                       margin: EdgeInsets.all(2),
                       elevation: 6,
                       child: Padding(
                         padding: EdgeInsets.all(5),
                         child: TextFormField(
                           controller: _searcController,
                           focusNode: _textFocus,
                           onChanged: onTextChange,
                           decoration: InputDecoration(
                               hintText: 'search',
                               prefixIcon: Icon(
                                 Icons.search,
                                 color: Cons.accent_color,
                                 size: 25,
                               ),
                               suffixIcon: IconButton(
                                 icon: Icon(
                                   Icons.filter_list_alt,
                                   color: Cons.accent_color,
                                   size: 25,
                                 ),
                                 onPressed: () {
                                   buildFilterDialogWidget(context);
                                 },
                               ),
                               // SizedBox(
                               //     width:10,
                               //     height:10,child: Image.asset('assets/images/nav_filter.png',width: 15,height: 15,)),
                               enabledBorder: UnderlineInputBorder(
                                 borderSide: BorderSide(
                                   color: Cons.accent_color,
                                   width: 1.0,
                                 ),
                               )
                             //ثى prefix: Icon(Icons.search,color: Cons.accent_color,)
                           ),
                         ),
                       ),
                     ),
                   ),
               Expanded(flex:2,child: ListTile(
                 title: Text('Name1'),
                 leading: CircleAvatar(
                   radius: 50,
                   backgroundImage: AssetImage('assets/images/store1.png'),
                 ),
                 trailing: IconButton(icon: Icon(Icons.message,color: Cons.accent_color,),),
               ))
                 ],
              ),
           // ),
         ),
         SliverList(delegate: SliverChildListDelegate(
           [
             SizedBox(height: 700,),
             Text('ddddddddddd')
           ]
         ))
       ],
     ),
    );
  }


  void buildFilterDialogWidget(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  Container(
                    padding: EdgeInsets.all(15),
                    // height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: SingleChildScrollView(
                      child: GetBuilder<ProductsController>(
                        builder: (_)=>
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Arrange Where:'),
                                RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                    'From High Price To Low',
                                    textAlign: TextAlign.start,
                                  ),
                                  value: 0,
                                  groupValue: _productController.filterRad,
                                  onChanged: (value) {
                                    _productController.filterRad=value;
                                    _productController.update();

                                  },
                                  activeColor: Cons.primary_color,
                                ),
                                //SizedBox(width: 10,)
                                RadioListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  value: 1,
                                  groupValue: _productController.filterRad,
                                  onChanged: (value) {
                                    _productController.filterRad=value;
                                    _productController.update();
                                  },
                                  title: Text('From Low Price To High'),
                                  activeColor: Cons.primary_color,
                                ),
                                //SizedBox(width: 30,),

                                Divider(
                                  color: Cons.primary_color,
                                  thickness: 1.5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Filter Where:',
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CheckboxListTile(
                                  value: _productController.statusNewChecked,
                                  onChanged: (val) {
                                    _productController.statusNewChecked=val;
                                    _productController.update();

                                  },
                                  title: Text('New Products'),
                                  activeColor: Cons.primary_color,
                                ),
                                //  SizedBox(height: 20,),
                                CheckboxListTile(
                                  value:   _productController.statusOldChecked,
                                  onChanged: (val) {
                                    _productController.statusOldChecked=val;
                                    _productController.update();
                                  },
                                  title: Text('Old Products'),
                                  activeColor: Cons.primary_color,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () async{
                                      _productController.changeFilterFlag(true);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Do Filter',
                                      style: Cons.whiteFont,
                                    ),
                                    color: Cons.accent_color,
                                  ),
                                )
                              ],
                            ),
                      ),
                    ),
                  ),
            ),
          );
        });
  }
  onTextChange(String text) {
    String text = _searcController.text;
    print('rrrr  $text');
    _productController.search(text);
  }


}
