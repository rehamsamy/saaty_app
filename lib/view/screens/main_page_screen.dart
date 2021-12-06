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

class _MainPageScreenState extends State<MainPageScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  double width, height;
  bool _isLoading = false;
  List<Product> allProducts = [];
  ProductController _productController = Get.find();
  String productsType;
  var _searcController = TextEditingController();
  FocusNode _textFocus = new FocusNode();
  var hintText;
  int filterRad = 0;
  bool statusOldChecked = false;
  bool statusNewChecked = false;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    //productsType=ModalRoute.of(context).settings.arguments ;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //  print(_searcController.text);
    width = MediaQuery
        .of(context)
        .size
        .width;
    height = MediaQuery
        .of(context)
        .size
        .height;
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
                      tabs: [
                        Tab(
                          text: 'Stores',
                        ),
                        Tab(
                          text: 'Watches',
                        ),
                        Tab(
                          text: 'Bracletes',
                        )
                      ],
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

  Widget buildGrid(int index) {
    _productController.orderProducts(index);
    return _isLoading == true
        ? Center(
      child: CircularProgressIndicator(),
    )
        : GetBuilder<ProductController>(
      init: _productController,
      builder: (_) =>
          buildSearchAndProducts(
              _productController.watchProducts,
              _productController.bracletesProducts),
    );
  }

  Widget buildSearchAndProducts(List<Product> prods1, List<Product> prods2) {
    if (_productController.searchList.length != 0 ||
        _searcController.text.isNotEmpty) {
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 8 / 9,
              crossAxisCount: 2),
          itemCount: _productController.searchList.length,
          itemBuilder: (ctx, inx) {
            // return storeGridItem(_productController.allProducts,inx);
            return ProductItemWidget(_productController.searchList[inx]);
          });
    } else if ((_productController.selectedTabIndex == 0 &&
        prods1.length == 0) ||
        (_productController.selectedTabIndex == 1 && prods2.length == 0)) {
      _productController.searchList.clear();
      return Center(
        child: Text('Empty Data'),
      );
    } else if ((_productController.selectedTabIndex == 0 &&
        prods1.length > 0) ||
        (_productController.selectedTabIndex == 1 && prods2.length > 0)) {
      _productController.searchList.clear();
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 8 / 9,
              crossAxisCount: 2),
          itemCount: _productController.selectedTabIndex == 0
              ? prods1.length
              : prods2.length,
          itemBuilder: (ctx, inx) {
            // return storeGridItem(_productController.allProducts,inx);
            return ProductItemWidget(_productController.selectedTabIndex == 0
                ? prods1[inx]
                : prods2[inx]);
          });
    }
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
        .then((value) => setState(() => _isLoading = false));
  }

  onTextChange(String text) {
    String text = _searcController.text;
    print('rrrr  $text');
    _productController.search(text);
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.95,
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
                              if (filterRad == 0 &&
                                  statusOldChecked == true &&
                                  statusNewChecked == true &&
                                  _productController.selectedTabIndex ==
                                      0) {} else if (filterRad == 0 &&
                                  statusOldChecked == true &&
                                  statusNewChecked == true &&
                                  _productController.selectedTabIndex == 1) {
                                List<Product> newProds =
                                Cons.selectionAsecSortFilter(
                                    _productController.bracletesProducts);
                                print('CCCCCCCCCCCC');
                                print(newProds.length);
                                setState(() {
                                  _productController.bracletesProducts =
                                      newProds;
                                  print('vvvvvvvvvvvvvvvvvvv');
                                  print(_productController
                                      .bracletesProducts.length);
                                });
                              } else if (filterRad == 1 &&
                                  statusOldChecked == true &&
                                  statusNewChecked == true &&
                                  _productController.selectedTabIndex == 1) {
                                List<Product> newProds =
                                Cons.selectionDescSortFilter(
                                    _productController.bracletesProducts);
                                print('DDDDDDDDDDD');
                                print(
                                    'new list size' +
                                        newProds.length.toString());
                                // setState((){
                                _productController.allProducts = newProds;
                                _productController.update();
                                print(_productController.allProducts.length);
                                // });

                              }
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
}}
