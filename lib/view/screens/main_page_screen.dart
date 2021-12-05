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
  int index;


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
                      onChanged: (val){
                        if(index==0){
                          print('watch $val');
                          for(Product x in watchProducts){
                            if(x.name.contains(val)){
                              print('yes');
                              setState(() {
                                watchProducts.add(x);
                              });
                            }
                          }
                        }else if(index==1){
                          print(bracletesProducts.length);
                          print('braclet');
                          for(Product x in bracletesProducts){
                            print('braclet e $val');
                            if(x.name.contains(val)){
                              print('yes $val');
                              setState(() {
                                searcList.add(x);
                               // bracletesProducts.add(x);
                              });
                            }
                          }
                           print(searcList.length);
                          bracletesProducts.clear();
                          setState(() {
                            bracletesProducts=searcList;
                          });

                        }

                      },
                      decoration: InputDecoration(
                        labelText: 'search',
                        prefixIcon: Icon(Icons.search,color: Cons.accent_color,size: 25,),
                       suffixIcon: Icon(Icons.filter_list_alt,color: Cons.accent_color,size: 25,),
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
          //  Center(child: Text('empty'),),
          //   buildGrid(0),
          //   Center(child: Text('empty'),),


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
  return  _isLoading==true? Center(child: CircularProgressIndicator(),):
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
            return (i==0 && watchProducts.length ==0)||(i==1 && bracletesProducts.length ==0)?
                Center(child: Text('Empty Data'),):
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio:8/9,
                    crossAxisCount: 2
                  ),
                    itemCount:i==0? watchProducts.length:bracletesProducts.length,
                    itemBuilder: (ctx,inx){

                   // return storeGridItem(_productController.allProducts,inx);
                      return ProductItemWidget(i==0? watchProducts[inx]:bracletesProducts[inx]);
                    }
              );
        });
    //   }
    // });

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


}