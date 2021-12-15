import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/tab_controller.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../../cons.dart';

class MainPageScreen extends StatefulWidget {
  static String MAIN_PRAGE_ROUTE = '/5';
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final MyTabController _tabx = Get.put(MyTabController());

  TabController _controller;
  double width, height;
  bool _isLoading = false;
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  ProductsController _productController = Get.find();
  ProductController _prod = Get.find();
  String productsType;
  var _searcController = TextEditingController();
  FocusNode _textFocus = new FocusNode();
  var hintText;
  int filterRad = 0;
  bool flag=false;
  bool statusOldChecked = false;
  bool statusNewChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //  print(_searcController.text);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
                child: AppBar(
                  title: Text('Stores', style: Cons.greyFont),
                  elevation: 8,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Cons.accent_color,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(MainPageScreen.MAIN_PRAGE_ROUTE);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
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
              Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 4,
                    child: TabBar(
                      onTap: (indx){
                          _productController.changeSelectedTab(indx);
                      print('!!!!!!!!!!! '+_productController.selectedTabIndex.toString());
                      },
                      tabs: _tabx.myTabs,
                      controller: _controller,
                    ),
                  )),
            ],
          ),
        ),
      ),
      body: Container(
        height: height * 0.7,
        child: TabBarView(
          controller: _controller,
          children:[
              buildGrid(0),
              buildGrid(1),
              buildGrid(2),
                   ]

          //_tabx.myTabs.map((tab) => buildGrid(_productController.selectedTabIndex)).toList()
          ,
        ),
      ),
      drawer: MyDrawer(),
    );
  }

  Widget buildGrid(int index) {
    List<Product> list=[];
    //int index=_productController.selectedTabIndex;
    //list=_productController.allProducts;

    print(',,,,,,,,,,,,,,,  '+index.toString());
    if(_searcController.text.isEmpty){
      print('++++++++++  '+index.toString());
      if(flag==false) {
        print('************ '+index.toString());
        print('flag equal => '+flag.toString());
        if (index == 0) {
          list = _productController.allProducts;
          print('!!!!!!!!!!!!!!!  '+list.length.toString()+index.toString());
        } else if (index == 1) {
          list = _productController.watchProductsList;
        } else if (index == 2) {
          list = _productController.bracletesProductsList;
        }
      }else {


          // list=_productController.filteredCheckRadioProducts;
          // list.forEach((element) {print(element.price);});


        if(index==0 && filterRad == 0 && statusOldChecked == true &&
            statusNewChecked == true){
          print('status =>  1');
          List<Product> newList=[];
          newList = _productController.allProducts;
          setState(() {
            list=Cons.selectionDescSortFilter(newList);
          });


        }
        else  if(index==0 && filterRad == 1 && statusOldChecked == true &&
            statusNewChecked == true){
          print('status =>  1');
          List<Product> newList=[];
          newList = _productController.allProducts;
          setState(() {
            print('bbbbbbbb');
            list=Cons.selectionAsecSortFilter(newList);
          });


        }
      }
    }else {
     // _productController.searchTextFormProducts.clear();
      _productController.txt=_searcController.text;
      print('-----------  '+_productController.txt);
      list=_productController.searchTextFormProducts;
      if(_searcController.text.isEmpty){
        list.clear();
      }
    }

    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GetBuilder<ProductsController>(
            init: _productController,
            initState: (_){
            },
            builder: (_) => list.length==0?
            Center(child: Text('Empty Data'),):
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 8 / 9,
                    crossAxisCount: 2),
                itemCount: list.length,
                itemBuilder: (ctx, inx) {

                  return ProductItemWidget(
                     list[inx]);
                })
            // buildSearchAndProducts(
            // ),
            );
  }


  Widget storeGridItem(List<Product> stores, int indx) {
    print('111111111');
    print(stores[indx].images.length);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                stores[indx].images[0],
                fit: BoxFit.contain,
              ),
              //Image.asset(stores[indx].images.,fit: BoxFit.contain,),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                stores[indx].name,
              ))
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
      _isLoading = true;
    });
    await _productController
        .fetchProducts('all')
        .then((value) => setState(() => _isLoading = false)).catchError((err)=>print('=>>>>>  $err'));
    print('length 44444444  => ${_productController.allProducts.length}');


  }

  onTextChange(String text) {
    String text = _searcController.text;
    print('rrrr  $text');
    // _productController.search(text);
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
                  child: Column(
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
                        groupValue: filterRad,
                        onChanged: (value) {
                          setState(() {
                            filterRad = value;
                          });
                        },
                        activeColor: Cons.primary_color,
                      ),
                      //SizedBox(width: 10,)
                      RadioListTile(
                        contentPadding: EdgeInsets.all(0),
                        value: 1,
                        groupValue: filterRad,
                        onChanged: (value) {
                          setState(() {
                            filterRad = value;
                          });
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
                        value: statusNewChecked,
                        onChanged: (val) {
                          setState(() {
                            statusNewChecked = val;
                          });
                        },
                        title: Text('New Products'),
                        activeColor: Cons.primary_color,
                      ),
                      //  SizedBox(height: 20,),
                      CheckboxListTile(
                        value: statusOldChecked,
                        onChanged: (val) {
                          setState(() {
                            statusOldChecked = val;
                          });
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
                          onPressed: () {
                            setState(()=>flag=true);
                          _productController.changeFilterFlag(true);
                           // filteredProducts= _productController.getfilteredCheckRadioProducts(filterRad, statusOldChecked, statusNewChecked);
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
          );
        });
  }
}
