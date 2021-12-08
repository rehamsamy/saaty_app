
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/product_model.dart';
import 'dart:convert';

import 'package:saaty_app/providers/auth_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:io';

import 'package:saaty_app/view/widget/product_item_widget.dart';

import '../cons.dart';

class ProductsController extends GetxController {
  List<Product> _allProds = [];
  List<Product> favProducts = [];
  List<Product> adsProducts = [];

  int filterRad = 0;
  bool statusOldChecked = false;
  bool statusNewChecked = false;
  String txt;

  int selectedTabIndex = 0;

  String token = AuthController.token;
  String userId = AuthController.userId;

  List<Product> get allProducts {
    return _allProds;
  }

  Future fetchProducts(String flag) async {
    allProducts.clear();
    favProducts.clear();
    String token = AuthController.token;
    String url;
    print(token);
    if (flag == 'fav') {
      url =
      'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites.json?auth=$token';
    } else if (flag == 'all' || flag == 'ads') {
      url =
      'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=$token';
    }
    try {
      var response = await http.get(Uri.parse(url));
      print('step0');
      if (response.statusCode == 200) {
        print('step1');
        Map<String, dynamic> result =
        json.decode(response.body) as Map<String, dynamic>;
        print(result);
        if (flag == 'all') {
          result.forEach((key, value) async {
            String prodId = value['id'];
            List<String> imgs;
            Product product = Product.fromJson(key, value);
            _allProds.add(product);
          });
          print('all prods size -----  ${_allProds.length}');
        } else if (flag == 'ads') {
          adsProducts.clear();
          result.forEach((key, value) async {
            if (value['id'] == AuthController.userId) {
              List<String> imgs;
              String prodId = value['id'];
              Product product = Product.fromJson(key, value);
              adsProducts.add(product);
              print('!!!!!!!!!!!   ${adsProducts.length}');
              print(adsProducts);
            }
          });
        } else if (flag == 'fav') {
          result.forEach((key, value) async {
            if (key == AuthController.userId) {
              value.forEach((key, val1) async {
                Product product = Product.fromJson(key, val1);
                _allProds.add(product);
                favProducts.add(product);
                print('fav  vvvv  => ${favProducts[0].id}');
              });
            }
          });
        }
      }
      print('ddd ${_allProds.length} ');
    } catch (err) {
      print(err);
    }

    update();
  }

  changeSelectedTab(int index) {
    selectedTabIndex = index;
    update();
  }

  List<Product> get watchProductsList {
    return _allProds.where((element) => element.cat == 0).toList();
  }

  List<Product> get bracletesProductsList {
    return allProducts.where((element) => element.cat == 1).toList();
  }

  List<Product> get searchTextFormProducts {
    String text = this.txt;
    return allProducts.where((element) => element.name.contains(text)).toList();
  }

  List<Product> get filteredCheckRadioProducts {
    int filterRad = this.filterRad;
    bool statusOldChecked = this.statusOldChecked;
    bool statusNewChecked = this.statusNewChecked;
    List<Product>_filterProducts = [];
    if (selectedTabIndex == 0) {
      _filterProducts = watchProductsList;
    } else if (selectedTabIndex == 1) {
      _filterProducts = bracletesProductsList;
    } else {
      _filterProducts = _allProds;
    }

    if (filterRad == 0 && statusOldChecked == true &&
        statusNewChecked == true) {
      print('filter 111');
      _allProds = Cons.selectionDescSortFilter(_filterProducts);
      return _allProds;


      // List<Product> get filteredCheckRadioProducts{
      //   int filterRad = this.filterRad;
      //   bool statusOldChecked = this.statusOldChecked;
      //   bool statusNewChecked = this.statusNewChecked;
      //   if (filterRad == 0 && statusOldChecked == true && statusNewChecked == true ) {
      //    _allProds= Cons.selectionDescSortFilter(allProducts);
      //     return _allProds;
      //   }
      //else if (filterRad == 0 && statusOldChecked == true && statusNewChecked == true &&) {
      //   List<Product> newProds =
      //   Cons.selectionAsecSortFilter(
      //       _productController.bracletesProductsList);
      //   print('CCCCCCCCCCCC');
      //   print(newProds.length);
      //   setState(() {
      //     // _productController.bracletesProductsList = newProds;
      //     print('vvvvvvvvvvvvvvvvvvv');
      //   });
      // } else if (filterRad == 1 &&
      //     statusOldChecked == true &&
      //     statusNewChecked == true &&
      //     _productController.selectedTabIndex == 1) {
      //   List<Product> newProds =
      //   Cons.selectionDescSortFilter(
      //       _productController.bracletesProductsList);
      //   print('DDDDDDDDDDD');
      //   print(
      //       'new list size' + newProds.length.toString());
      //
      // }

    }
  }
}