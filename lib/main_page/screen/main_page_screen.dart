import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saaty_app/main_page/widget/bottom_navigation_main_page.dart';
import 'package:saaty_app/main_page/widget/filter_dialog_main_page.dart';
import 'package:saaty_app/main_page/widget/grid_list_main_page.dart';
import 'package:saaty_app/main_page/widget/grid_list_store_main_page.dart';
import 'package:saaty_app/model/cart.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/create_product/screen/create_product_screen.dart';
import 'package:saaty_app/login_register/screen/login_screen.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/main_page/widget/badge.dart';
import 'package:saaty_app/view/widget/visitor_drawer.dart';

import '../../cons.dart';

class MainPageScreen extends StatefulWidget {
  static String MAIN_PRAGE_ROUTE = '/5';
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
  String productsType;
  var _searcController = TextEditingController();
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
      Future.delayed(Duration(seconds: 1)).then((value) =>   _productController.changeSelectedTab(pos));
    }

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
                                 FilterProductDialog.buildFilterDialogWidget(context);
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Cons.accent_color,
                                  width: 1.0,
                                ),
                              )
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
                GrisListProductsMain(_searcController,_isLoading),
                GrisListProductsMain(_searcController,_isLoading),
                GrisListProductsMain(_searcController,_isLoading),
                GridListStoresMain()
              ],
            ),
            drawer:
                StorageController.getString(StorageController.type) == 'guest'
                    ? VisitorDrawer()
                    : MyDrawer(),
            bottomNavigationBar: BottomNavigationMain(),
            floatingActionButton: _fab(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked),
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;

  Future fetchData() async {
    setState(() {
      _isLoading = true;
    });
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


}
