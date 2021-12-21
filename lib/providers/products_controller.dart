import 'package:flutter/cupertino.dart';
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
  List<Product> _favProducts = [];
  List<Product> adsProducts = [];

  int filterRad = 0;
  bool statusOldChecked = false;
  bool statusNewChecked = false;
  String txt;
  bool isFiltering = false;


  int selectedTabIndex = 0;

  String token = AuthController.token;
  String userId = AuthController.userId;

  List<Product> get allProducts {
    return _allProds;
  }
  List<Product> get favProducts {
    return _favProducts;
  }

  Future fetchProducts(String flag) async {
    allProducts.clear();
    favProducts.clear();
    String token = AuthController.token;
    String url;
    print(token);
    String urlFav='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}.json?auth=$token';
    if (flag == 'fav') {
      url =
          'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites.json?auth=$token';
    } else if (flag == 'all' || flag == 'ads') {
      url =
          'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=$token';
    }
    try {
      var favResponse=await http.get(Uri.parse(urlFav));
      var response = await http.get(Uri.parse(url));
      print('step0');
      if (response.statusCode == 200&& favResponse.statusCode==200) {
        print('step1');
        Map<String, dynamic> result =
            json.decode(response.body) as Map<String, dynamic>;

        var favResult=  json.decode(favResponse.body) as Map<String, dynamic>;

        print(result);
        if (flag == 'all') {
          result.forEach((key, value) async {
            String prodId = value['id'];
            List<String> imgs;
            Product product = Product.fromJson(key, value);
            product.isFav=favResult[key];
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
                Product product = Product.fromJson(val1['id'], val1);
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
    getFinalProducts();
  }

  changeSelectedTab(int index) async {
    selectedTabIndex = index;
    getFinalProducts();
  }

  changeFilterFlag(bool value) async {
    isFiltering = value;
    getFinalProducts();
  }



  List<Product> get watchProductsList {
    return _allProds.where((element) => element.cat == 0).toList();
  }

  List<Product> get bracletesProductsList {
    return allProducts.where((element) => element.cat == 1).toList();
  }

  List<Product> filteredList = [];

  void getFinalProducts() {
    print('flag  ' + isFiltering.toString());
    if (txt.isEmpty) {
      if (isFiltering == false) {
        if (selectedTabIndex == 0) {
          filteredList = allProducts;
        } else if (selectedTabIndex == 1) {
          filteredList = watchProductsList;
        } else if (selectedTabIndex == 2) {
          filteredList = bracletesProductsList;
        }
      } else {
        if (selectedTabIndex == 0 &&
            filterRad == 0 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = allProducts;
          filteredList = Cons.selectionDescSortFilter(newList);
        } else if (selectedTabIndex == 0 &&
            filterRad == 1 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = allProducts;
          print('888888888  ' + newList.length.toString());
          filteredList = Cons.selectionAsecSortFilter(newList);
          print('888888888  ' + filteredList.length.toString());
        } else if (selectedTabIndex == 1 &&
            filterRad == 1 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = watchProductsList;
          filteredList = Cons.selectionAsecSortFilter(newList);
        } else if (selectedTabIndex == 1 &&
            filterRad == 0 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = watchProductsList;
          filteredList = Cons.selectionDescSortFilter(newList);
        } else if (selectedTabIndex == 2 &&
            filterRad == 1 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = bracletesProductsList;
          filteredList = Cons.selectionAsecSortFilter(newList);
        } else if (selectedTabIndex == 2 &&
            filterRad == 0 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = bracletesProductsList;
          filteredList = Cons.selectionDescSortFilter(newList);
        }
      }
    } else {
      // _productController.searchTextFormProducts.clear();
      print('-----------  ' + txt);
      filteredList = searchTextFormProducts;
      if (txt.isEmpty) {
        filteredList.clear();
      }
    }
    update();
  }

  List<Product> get searchTextFormProducts {
    String text = this.txt;
    print('-----------  ' + text);
    if (selectedTabIndex == 0) {
      return allProducts
          .where((element) => element.name.contains(text))
          .toList();
    } else if (selectedTabIndex == 1) {
      return watchProductsList
          .where((element) => element.name.contains(text))
          .toList();
    } else if (selectedTabIndex == 2) {
      return bracletesProductsList
          .where((element) => element.name.contains(text))
          .toList();
    }
  }

  List<Product> get filteredCheckRadioProducts {
    print('select  tabbbb ' + selectedTabIndex.toString());
    List<Product> _filterProducts = [];
    // if (selectedTabIndex == 0) {
    //   _filterProducts = allProducts;
    // } else if (selectedTabIndex == 1) {
    //   _filterProducts = watchProductsList;
    // } else {
    //   _filterProducts = bracletesProductsList;
    // }

    //_filterProducts=newList;
    if (selectedTabIndex == 0 &&
        filterRad == 0 &&
        statusOldChecked == true &&
        statusNewChecked == true) {
      print('filter 111' + _filterProducts.length.toString());
      _allProds = Cons.selectionAsecSortFilter(allProducts);
      print('after filter   ' + _allProds.length.toString());
    } else if (selectedTabIndex == 0 &&
        filterRad == 1 &&
        statusOldChecked == true &&
        statusNewChecked == true) {
      _allProds = Cons.selectionDescSortFilter(_filterProducts);
    }
    //update();
    allProducts.clear();
    //allProducts=_allProds;
    return _allProds;
  }

  Future toggleFav(String id, Map<String, dynamic> map) async {
    String token = AuthController.token;
    print(AuthController.userId);
    // print('favvvvvvvv  '+favProducts.length.toString());
    print(id);
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}.json?auth=$token';
    ;
    String url1 =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}/$id.json?auth=$token';
    int flag = 0;
    var response;
    int index = allProducts.indexWhere((element) => element.id == id);
    // map['id']=index;
    if (favProducts.length != 0) {
      print('1111111111111111');
      favProducts.firstWhere((element) {
        if (element.id == id) {
          print('exist');
          flag = 1;
        } else {
          flag = 0;
          print('not exist');
        }
      });
      // favProducts.firstWhere((element) => (element.id == id)) == null
      //     ? flag = 0
      //     : flag = 1;
    }

    print('flagggggg  = $flag');

    if (flag == 0) {
      response = await http.post(Uri.parse(url), body: json.encode(map));
    } else {
      response = await http.patch(Uri.parse(url1), body: json.encode(map));
    }

    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
        print('yesss');
      } else {
        print('noooooo');
      }
    } on Exception catch (e) {
      print(e);
    }
    // allProducts[index] = Product.fromJson(id, map) as Product;
    // update();
  }

  void search(String text) {
    txt = text;
    getFinalProducts();
  }


}


