import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/model/store_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../../cons.dart';

class MainPageScreen extends StatefulWidget {
  static String MAIN_PRAGE_ROUTE = '/5';
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> with SingleTickerProviderStateMixin ,AutomaticKeepAliveClientMixin  {
  TabController _controller;
  double width,height;
  bool _isLoading=false;
  List<Product> allProducts=[];
  List<Product> watchProducts=[];
  List<Product> bracletesProducts=[];
  List<Product> searcList=[];
  ProductController _productController=Get.find();
  String productsType;
  var _searcController=TextEditingController();
  FocusNode _textFocus = new FocusNode();
  var hintText;
  int index;
  var _filterRad=0;
  bool statusOldChecked=false;
  bool statusNewChecked=false;



  @override
  void initState() {
    super.initState();
    _controller=TabController(length: 3, vsync: this);
    //productsType=ModalRoute.of(context).settings.arguments ;
    fetchData();

  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
   //  print(_searcController.text);
     width=MediaQuery.of(context).size.width;
     height=MediaQuery.of(context).size.height;
   // FocusManager.instance.primaryFocus.unfocus();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          //height: 250,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                  child: AppBar( title: Text('Stores',style: Cons.greyFont),
                  elevation:8,
                  actions: [
                    IconButton(icon:Icon(Icons.home,color: Cons.accent_color,size: 25,),
                    onPressed: (){Navigator.of(context).pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);},),
                  ],),),
              SizedBox(height: 2,),
              Expanded(
                flex: 1,
                child: Card(
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
                        prefixIcon: Icon(Icons.search,color: Cons.accent_color,size: 25,),
                       suffixIcon: IconButton(icon:Icon(Icons.filter_list_alt
                         ,color: Cons.accent_color,size: 25,),
                       onPressed: (){
                         buildFilterDialogWidget(context);
                       },),
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
              Expanded(
                  flex:1,child: Card(
                elevation: 4,
                    child: TabBar(tabs: [
                      Tab(text: 'Stores',),
                      Tab(text: 'Watches',),
                      Tab(text: 'Bracletes',)
              ],
                controller: _controller,
              ),
                  )),
            ],
          ),
        ),
      )
     ,
      body: Container(
        height: height*0.7,
        child: TabBarView(
          controller: _controller,
          children: [
           buildGrid(2),
            buildGrid(0),
          buildGrid(1),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }

Widget  buildGrid(int i) {
    setState(() {
      index=i;
    });
  return  StatefulBuilder(
      builder: (BuildContext context, StateSetter setState)=>
     _isLoading==true? Center(child: CircularProgressIndicator(),):
           GetBuilder<ProductController>(
            init: _productController,
              builder: (_){
                watchProducts.clear();
                bracletesProducts.clear();
                print('ddd ${ _productController.allProducts.length}  $i');
                _productController.allProducts.forEach((element) {
                  if(element.cat==0 && i==0){
                    watchProducts.add(element);
                    print(element.name);
                  }else if (element.cat==1 && i==1){
                    bracletesProducts.add(element);
                  }
                });
              return  buildSearchAndProducts(watchProducts, bracletesProducts, i);

          }),
  );
    //   }
    // });

  }

  Widget buildSearchAndProducts(List<Product>prods1,List<Product>prods2,int i){
    if(searcList.length != 0 || _searcController.text.isNotEmpty){
      return
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio:8/9,
              crossAxisCount: 2
          ),
          itemCount:searcList.length,
          itemBuilder: (ctx,inx){

            // return storeGridItem(_productController.allProducts,inx);
            return ProductItemWidget(searcList[inx]);
          }
      );
    }else if((i==0 && prods1.length ==0)||(i==1 && prods2.length==0)){
      searcList.clear();
      return  Center(child: Text('Empty Data'),);
    }else if((i==0 && prods1.length >0)||(i==1 && prods2.length>0)){
      searcList.clear();
      return   GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio:8/9,
              crossAxisCount: 2
          ),
          itemCount:i==0? prods1.length:prods2.length,
          itemBuilder: (ctx,inx){

            // return storeGridItem(_productController.allProducts,inx);
            return ProductItemWidget(i==0? prods1[inx]:prods2[inx]);
          }
      );
    }
  }


  Widget storeGridItem(List<Product> stores,int indx){
    print('111111111');
    print(stores[indx].images.length);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child:
         Card(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10)
           ),
           elevation: 8,
           child: Padding(
             padding:EdgeInsets.fromLTRB(1, 0, 1, 0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Image.network(stores[indx].images[0],fit: BoxFit.contain,),
                 //Image.asset(stores[indx].images.,fit: BoxFit.contain,),
                 SizedBox(height: 10,),
                 Center(child: Text(stores[indx].name,))
               ],
             ),
           ),
         ),
    );
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();

  @override
  bool get wantKeepAlive => true;

  Future fetchData() async {
    setState(() {
      _isLoading=true;
    });
    await _productController.fetchProducts('all').then((value) => setState(()=>_isLoading=false));

  }
   onTextChange( String text){
    String text = _searcController.text;
    print('rrrr  $text');
    searcList.clear();

    if (text.isEmpty) {
      setState(() {});
      return;
    }

      if(index==0){
        print('watch $text');
        for(Product x in watchProducts){
          if(x.name.contains(text)){
            print('yes');
            setState(() {
              watchProducts.add(x);
            });
          }
        }
      }else if(index==1){
        
        bracletesProducts.forEach((element) { 
          if(element.name .contains(text)){
            searcList.add(element);
            print('ffff   ${searcList.length}');
          }
          setState(() {});

        });
      }

  }

  void buildFilterDialogWidget(BuildContext context) {

    showDialog(context: context, builder: (ctx){
      return
            AlertDialog(
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState)=>
               Container(
                padding: EdgeInsets.all(15),
               // height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.95,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Arrange Where:'),
                          RadioListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text('From High Price To Low',textAlign: TextAlign.start,),
                            value: 0, groupValue: _filterRad, onChanged: (value){
                            setState(() {
                              _filterRad=value;
                            });
                          },
                            activeColor:Cons.primary_color ,),
                          //SizedBox(width: 10,)
                          RadioListTile(
                            contentPadding: EdgeInsets.all(0),
                            value: 1, groupValue: _filterRad, onChanged: (value){
                            setState(() {
                              _filterRad=value;
                            });
                          },
                            title : Text('From Low Price To High'),
                            activeColor:Cons.primary_color ,),
                          //SizedBox(width: 30,),

                      Divider(color: Cons.primary_color,thickness: 1.5,),
                      SizedBox(height: 10,),
                      Text('Filter Where:',textAlign: TextAlign.start,),
                      SizedBox(height: 10,),
                      CheckboxListTile(value: statusNewChecked, onChanged: (val){
                        setState((){
                          statusNewChecked=val;
                        });
                      },title: Text('New Products'),
                      activeColor: Cons.primary_color,),
                    //  SizedBox(height: 20,),
                      CheckboxListTile(value: statusOldChecked, onChanged: (val){
                        setState((){
                          statusOldChecked=val;
                        });

                      },title: Text('Old Products'),
                        activeColor: Cons.primary_color,),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: (){
                            if(_filterRad==0&&statusOldChecked==true && statusNewChecked==true&& index==0){

                            }else if(_filterRad==0&&statusOldChecked==true && statusNewChecked==true&& index==1){
                              print('CCCCCCCCCCCC');
                              List<Product> newWishlist=[];
                              for (int i = 0; i < bracletesProducts.length; i++) {
                                // find position of smallest num between (i + 1)th element and last element
                                int pos = i;
                                for (int j = i; j < newWishlist.length; j++) {
                                  if (double.parse(newWishlist[j].price) > double.parse(newWishlist[pos].price))
                                    pos = j;
                                }
                                // Swap min (smallest num) to current position on array
                                Product  min = newWishlist[pos];
                                newWishlist.setAll(pos, newWishlist);
                                //newWishlist.set(pos, newWishlist.get(i));
                                newWishlist.setAll(i, newWishlist);
                              }

                              setState((){
                                bracletesProducts.addAll(newWishlist);
                              });

                            }
                          Navigator.of(context).pop();
                          },child:
                        Text('Do Filter',style: Cons.whiteFont,),
                          color: Cons.accent_color,),
                      )

                    ],
                  ),
                ),
              ),
            ),

         );
    });

  }


}