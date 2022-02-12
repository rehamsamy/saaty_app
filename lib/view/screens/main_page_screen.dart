import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/view/screens/create_product_screen.dart';
import 'package:saaty_app/view/screens/home_screen.dart';
import 'package:saaty_app/view/screens/login_screen.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/badge.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';
import 'package:saaty_app/view/widget/store_item_widget.dart';
import 'package:saaty_app/view/widget/visitor_drawer.dart';

import '../../cons.dart';
import 'cart_screen.dart';

class MainPageScreen extends StatefulWidget {
  static String MAIN_PRAGE_ROUTE = '/5';
  StorageController _storageController = Get.find();

  static String token;
  static String userId;
  static DateTime expire;

  buildStorage() {
    token = StorageController.getString(StorageController.apiToken);
    userId = StorageController.getString(StorageController.userId);
  }

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
  Cart _cart = Get.find();
  AuthController _authController = Get.find();
  ProductController _prod = Get.find();
  String productsType;
  var _searcController = TextEditingController();
  var _storageontroller = Get.put(StorageController());
  FocusNode _textFocus = new FocusNode();
  TabController _tabController;
  var hintText;
  int filterRad = 0;
  bool flag = false;
  Map<String, dynamic> _userData;
  int pos;

  @override
  void initState() {
    super.initState();
    if (!StorageController.isGuest) {
      _userData = jsonDecode(
          StorageController.getString(StorageController.loginDataKey));
      MainPageScreen.expire = DateTime.parse(
          StorageController.getString(StorageController.expireDate));
      String nowFormat =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      DateTime nowRes = DateTime.parse(nowFormat);
      if (MainPageScreen.expire != null) {
        if (MainPageScreen.expire.isAfter(nowRes)) {
          MainPageScreen.token = _userData['idToken'];
          MainPageScreen.userId = _userData['localId'];
          print('88888  ' +
              MainPageScreen.userId +
              '      ;fff   ' +
              MainPageScreen.token);
        } else {
          Future.delayed(Duration.zero, () {
            Navigator.of(context)
                .pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
          });
        }
      }
    } else {}

    fetchData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    pos = ModalRoute.of(context).settings.arguments as int;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    if (pos != null) {
      _productController.changeSelectedTab(pos);
    }

    // FocusManager.instance.primaryFocus.unfocus();
    return DefaultTabController(
      length: 3,
      child: GetBuilder<ProductsController>(
        builder: (_) => Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(130),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppBar(
                        title: Text('main_page'.tr, style: Cons.greyFont),
                        elevation: 6,
                        actions: [
                          GetBuilder<Cart>(
                            builder: (_) =>
                                Badge(_cart.itemCount.toString(), Colors.red),
                          ),
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
                        elevation: 5,
                        child: TextFormField(
                          controller: _searcController,
                          focusNode: _textFocus,
                          onChanged: onTextChange,
                          decoration: InputDecoration(
                              hintText: 'search'.tr,
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
                    SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ),
            ),
            body: IndexedStack(
              index: _productController.selectedTabIndex,
              children: [
                buildGrid(),
                buildGrid(),
                buildGrid(),
                buildStoreGrid(),
              ],
            ),
            drawer:
                StorageController.getString(StorageController.type) == 'guest'
                    ? VisitorDrawer()
                    : MyDrawer(),
            bottomNavigationBar: _bottomNav(),
            floatingActionButton: _fab(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked),
      ),
    );
  }

  Widget buildGrid() {
    _productController.txt = _searcController.text;
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _productController.filteredList.isEmpty
            ? Center(
                child: Text('empty_data'.tr),
              )
            : GetBuilder<ProductsController>(
                builder: (_) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 8 / 9,
                        crossAxisCount: 2),
                    itemCount: _productController.filteredList.length,
                    itemBuilder: (ctx, inx) {
                      return ProductItemWidget(
                          _productController.filteredList[inx]);
                    }),
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

  @override
  bool get wantKeepAlive => true;

  Future fetchData() async {
    await _productController
        .fetchStores()
        .then((value) => print('length 44444444  => '));
    await Future.delayed(Duration(milliseconds: 50));
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 20));
    _productController
        .fetchProducts('all')
        .then((value) => setState(() => _isLoading = false))
        .catchError((err) => print('=>>>>>  $err'));
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
                child: SingleChildScrollView(
                  child: GetBuilder<ProductsController>(
                    builder: (_) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('arrange'.tr),
                        RadioListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            'from_high'.tr,
                            textAlign: TextAlign.start,
                          ),
                          value: 0,
                          groupValue: _productController.filterRad,
                          onChanged: (value) {
                            _productController.filterRad = value;
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
                            _productController.filterRad = value;
                            _productController.update();
                          },
                          title: Text('from_low'.tr),
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
                          'filter'.tr,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CheckboxListTile(
                          value: _productController.statusNewChecked,
                          onChanged: (val) {
                            _productController.statusNewChecked = val;
                            _productController.update();
                          },
                          title: Text('new_prods'.tr),
                          activeColor: Cons.primary_color,
                        ),
                        //  SizedBox(height: 20,),
                        CheckboxListTile(
                          value: _productController.statusOldChecked,
                          onChanged: (val) {
                            _productController.statusOldChecked = val;
                            _productController.update();
                          },
                          title: Text('old_prods'.tr),
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
                            onPressed: () async {
                              _productController.changeFilterFlag(true);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'execute'.tr,
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

  buildStoreGrid() {
    return _isLoading == true
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _productController.allStores.isEmpty
            ? Center(
                child: Text('empty_data'.tr),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 1,
                    crossAxisCount: 2),
                itemCount: _productController.allStores.length,
                itemBuilder: (ctx, inx) {
                  return StoreItemWidget(
                      _productController.allStores[inx], inx);
                });
  }

  _bottomNav() {
    return GetBuilder<ProductController>(
      builder: (_) => Container(
        height: 65,
        child: BottomAppBar(
          color: Cons.primary_color,
          child: new Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.blueGrey.shade500,
                primaryColor: Colors.red,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            // sets the inactive color of the `BottomNavigationBar`
            child: new BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _productController.selectedTabIndex,
              selectedItemColor: Cons.primary_color,
              onTap: (ind) {
                _productController.changeSelectedTab(ind);
                _productController.update();
                print('.....   ' +
                    _productController.selectedTabIndex.toString());
              },
              items: [
                new BottomNavigationBarItem(
                    icon: new Icon(
                      Icons.more_horiz,
                      color: checkBottomColor(0),
                    ),
                    title: new Text('all'.tr,
                        style: TextStyle(
                          color: checkBottomColor(0),
                        ))),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.watch_outlined,
                      color: checkBottomColor(1)),
                  title: new Text('watch'.tr,
                      style: TextStyle(color: checkBottomColor(1))),
                ),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.stream, color: checkBottomColor(2)),
                  title: new Text('braclete'.tr,
                      style: TextStyle(color: checkBottomColor(2))),
                ),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.shop, color: checkBottomColor(3)),
                  title: new Text('stores'.tr,
                      style: TextStyle(color: checkBottomColor(3))),
                ),
              ],
            ),
          ),
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.0,
        ),
      ),
    );
  }

  _fab() {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      backgroundColor: Cons.accent_color,
      onPressed: () {
        StorageController.isGuest
            ? Navigator.of(context).pushNamed(LoginScreen.LOGIN_SCREEN_ROUTE)
            : Navigator.of(context)
                .pushNamed(CreateProductScreen.CREATE_PRODUCT_ROUTE);
      },
    );
  }

  checkBottomColor(int index) {
    return _productController.selectedTabIndex == index
        ? Cons.primary_color
        : Colors.white;
  }
}
