import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
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
  bool flag = false;

  @override
  void initState() {
    super.initState();
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
              GetBuilder<ProductController>(builder: (_) {
                int index = _productController.selectedTabIndex;
                return Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 5,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Text('Stores'),
                            onTap: () {
                              _productController.changeSelectedTab(0);
                            },
                          ),
                          InkWell(
                            child: Text('Watches'),
                            onTap: () {
                              _productController.changeSelectedTab(1);
                              print('index   ?   '+_productController.selectedTabIndex.toString());
                            },
                          ),
                          InkWell(
                            child: Text('Bracletes'),
                            onTap: () => _productController.changeSelectedTab(2),
                          ),
                        ]),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      body: GetBuilder<ProductsController> (builder: (productController) {
        print('index'+productController.selectedTabIndex.toString());
        return  buildGrid();
        // buildGrid(productController.selectedTabIndex ?? 0)
      }),
      drawer: MyDrawer(),
    );
  }

  Widget buildGrid() {
    _productController.txt=_searcController.text;
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _productController.filteredList.isEmpty
            ? Center(
                child: Text('Empty Data'),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 8 / 9,
                    crossAxisCount: 2),
                itemCount: _productController.filteredList.length,
                itemBuilder: (ctx, inx) {
                  return ProductItemWidget(_productController.filteredList[inx]);
                });
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
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 200));
     _productController
        .fetchProducts('all')
        .then((value) => setState(() => _isLoading = false))
        .catchError((err) => print('=>>>>>  $err'));
    print('length 44444444  => ${_productController.allProducts.length}');




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



}
