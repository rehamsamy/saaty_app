import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saaty_app/home_page/widget/grid_list_home.dart';
import 'package:saaty_app/home_page/widget/listview_category_home.dart';
import 'package:saaty_app/providers/auth_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'package:saaty_app/home_page/widget/CategoryItem.dart';
import 'package:saaty_app/view/widget/app_drawer.dart';
import 'package:saaty_app/view/widget/images_slider_view.dart';
import 'package:saaty_app/home_page/widget/new_product_widget.dart';
import 'package:saaty_app/view/widget/product_item_widget.dart';
import 'package:saaty_app/view/widget/visitor_drawer.dart';

import '../../cons.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../login_register/screen/login_screen.dart';
import '../../main_page/screen/main_page_screen.dart';

class HomeScreen extends StatefulWidget {
  static String HOME_SCREEN_RIUTE = '/3';

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'assets/images/store1.png',
    'assets/images/store2.png',
    'assets/images/store3.png',
    'assets/images/store4.png'
  ];
  bool _isLoading = false;
  ProductsController _productController = Get.find();

  int _index = 0;
  AuthController _authController = Get.find();
  double width, height;
  static String token;
  static String userId;
  DateTime expire;
  Map<String, dynamic> _userData;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();

    if (!StorageController.isGuest) {
      Future.delayed(Duration.zero, () {
        Cons.buildColors(context);
        _userData = jsonDecode(
            StorageController.getString(StorageController.loginDataKey));
        DateTime expire = DateTime.parse(
            StorageController.getString(StorageController.expireDate));
        String nowFormat =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        DateTime nowRes = DateTime.parse(nowFormat);
        print('    expire            ' + expire.toString());
        if (expire != null) {
          if (expire.isAfter(nowRes)) {
            MainPageScreen.token = _userData['idToken'];
            MainPageScreen.userId = _userData['localId'];
          } else {
            Future.delayed(Duration.zero, () {
              Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.LOGIN_SCREEN_ROUTE);
            });
          }
        }

        _productController.fetchHomeProducts();
        fetchUserData();

        fetchData();
      });
    } else {
      _productController.fetchHomeProducts();
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    Cons.buildColors(context);
    CarouselController buttonCarouselController = CarouselController();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'main_page'.tr,
                style: Cons.greyFont,
              ),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              HomeImagesSlider(sliders: [
                'https://firebasestorage.googleapis.com/v0/b/saaty-9ba9f.appspot.com/o/splash%2Fstore1.png?alt=media&token=a92d3292-3f34-4425-a447-ccf14be0cb22',
                'https://firebasestorage.googleapis.com/v0/b/saaty-9ba9f.appspot.com/o/splash%2Fstore3.png?alt=media&token=67249df3-fdd6-4455-9fb5-0382d1fdd0c6',
                'https://firebasestorage.googleapis.com/v0/b/saaty-9ba9f.appspot.com/o/splash%2Fstore2.png?alt=media&token=a5780904-a980-4c40-ad42-611950167e55',
                'https://firebasestorage.googleapis.com/v0/b/saaty-9ba9f.appspot.com/o/splash%2Fstore1.png?alt=media&token=a92d3292-3f34-4425-a447-ccf14be0cb22',
                'https://firebasestorage.googleapis.com/v0/b/saaty-9ba9f.appspot.com/o/splash%2Fsplash_photo_3.png?alt=media&token=7a4d66c8-906d-4177-b32e-a31c43669d48',
                'https://firebasestorage.googleapis.com/v0/b/saaty-9ba9f.appspot.com/o/splash%2Fhome_ads.png?alt=media&token=beae77f9-8ca8-4cba-abdf-026385418546'
                // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
                // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
                // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
                // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
              ]),
              SizedBox(
                height: 5,
              ),
              ListTile(
                horizontalTitleGap: 0,
                leading: Icon(
                  Icons.drag_indicator_rounded,
                  color: Cons.accent_color,
                ),
                title: Text(
                  'catgory'.tr,
                  //textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              CategoryListView(),
              ListTile(
                horizontalTitleGap: 0,
                leading: Icon(
                  Icons.card_giftcard,
                  color: Cons.accent_color,
                ),
                title: Text(
                  'new'.tr,
                  //textDirection: TextDirection.rtl,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ]),
          ),
          HomeListGrid()
        ],
      ),
      drawer: StorageController.getString(StorageController.type) == 'guest'
          ? VisitorDrawer()
          : MyDrawer(),
    );
  }


  Future fetchData() async {
    await Future.delayed(Duration(milliseconds: 20));
    _productController
        .fetchProducts('all')
        .then((value) => setState(() => _isLoading = false))
        .catchError((err) => print('=>>>>>  $err'));
  }

  void fetchUserData() async {
    await _authController.getUserDate();
  }
}
