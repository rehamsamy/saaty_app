import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/model/user_model.dart';
import 'dart:convert';

import 'package:saaty_app/providers/auth_controller.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:saaty_app/view/screens/main_page_screen.dart';
import 'dart:async';
import '../cons.dart';

class ProductsController extends GetxController {
  List<Product> _allProds = [];
  List<Product> _adsProducts = [];
  List<Product> _favProducts = [];
  List<UserModel> _storesList = [];
  AuthController _authController=Get.find();

  int filterRad = 0;
  bool statusOldChecked = false;
  bool statusNewChecked = false;
  String txt=null;
  bool isFiltering = false;
  bool isLoading = true;
  String prodTypeFlag=null;


  int selectedTabIndex =0;

  String token = MainPageScreen.token;
  String userId = MainPageScreen.userId;

  List<Product> get allProducts {
    return _allProds;
  }

  List<UserModel> get allStores {
    return _storesList;
  }

  List<Product> get favProducts {
    return _favProducts;
  }

  List<Product> get addsProduct {
    return _adsProducts;
  }

  List<Product> get homeProducts{

    List products = [
      "2019-11-25 00:00:00.000",
      "2019-11-22 00:00:00.000",
      "2019-11-22 00:00:00.000",
      "2019-11-24 00:00:00.000",
      "2019-11-23 00:00:00.000"
    ];
    List<DateTime> newProducts = [];
    DateFormat format = DateFormat("yyyy-MM-dd");

    for (int i = 0; i < 5; i++) {
      newProducts.add(format.parse(products[i]));
    }
    newProducts.sort((a,b) => a.compareTo(b));

    for (int i = 0; i < 5; i++) {
      print(newProducts[i]);
    }
    return _allProds.sort((a,b)=>a.compareTo(b))
  }

  List<Product> get watchProductsList {
    return _allProds.where((element) => element.cat == 0).toList();
  }

  List<Product> get bracletesProductsList {
    return allProducts.where((element) => element.cat == 1).toList();
  }


  Future fetchProducts(String flag) async {
    allProducts.clear();
    favProducts.clear();
    addsProduct.clear();
    String token = MainPageScreen.token;
    print('-----  '+_authController.visitorFlag.toString());
    String urlFav='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/$token.json?auth=$token';
  String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json';

    try {

      if(!_authController.visitorFlag){
        var favResponse=await http.get(Uri.parse(urlFav));
        var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> result =
        json.decode(response.body) as Map<String, dynamic>;
        var favResult = json.decode(favResponse.body) as Map<String, dynamic>;
        if (flag == 'all') {
          result.forEach((key, value) async {
            Product product = Product.fromJson(key, value);
            if (favResponse.statusCode == 200) {
              if (favResponse.body.isEmpty) {
                product.isFav = favResult[key];
              } else {
                product.isFav = 0;
              }
            }
            print(product.isFav.toString() + "  " + product.id);
            _allProds.add(product);
          });
        }
      }
      }else{
        print('here ');
        var response = await http.get(Uri.parse(url));
        print(response.statusCode.toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> result =
          json.decode(response.body) as Map<String, dynamic>;
          result.forEach((key, value) async {
            Product product = Product.fromJson(key, value);
            print(product.isFav.toString() + "  " + product.id);
            _allProds.add(product);
          });

        }

      }
        getFinalProducts();


    } catch (err) {
      print(err);
    }

  }

  Future fetchStores()async{
print(token);
    String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/users.json';
     _storesList.clear();
     try {
      var response = await http.get(Uri.parse(url));
      print('vvv  vv     '+response.statusCode.toString());
      if (response.statusCode == 200) {
        var result =
        json.decode(response.body) as Map<String, dynamic>;
        result.forEach((key, value) {
          print(value);
          if(value['type']=='1'){
            print('yes');
            UserModel userModel=UserModel.fromJson(value,key);
            _storesList.add(userModel);
          }
        });

        update();
      }
   }
    catch(err){
       print('0000  '+err);
    }
  }

  changeSelectedTab(int index) async {
    selectedTabIndex = index;
    getFinalProducts();
  }

  changeFilterFlag(bool value) async {
    isFiltering = value;
    getFinalProducts();
  }


  changeIsLoadingFlag(bool value) async {
    isLoading = value;
   // update();
    //getFinalProducts();
  }

  changeProdTypeFlag(String flag){
    prodTypeFlag=flag;
    print('new flag  '+prodTypeFlag);
    update();
  }



  List<Product> filteredList = [];

  void getFinalProducts() {
    print('flag  ' + isFiltering.toString());
    if (txt.isEmpty) {
      if (isFiltering == false) {
        if (selectedTabIndex == 0 ) {
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
          filteredList = Cons.selectionAsecSortFilter(newList);
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
      filteredList = searchTextFormProducts;
      if (txt.isEmpty) {
        filteredList.clear();
      }
    }
    update();
  }


  List<Product> get searchTextFormProducts {
    String text = this.txt;
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
    // print('favvvvvvvv  '+favProducts.length.toString());
    print(id);
    String url =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/$token.json?auth=$token';
    ;
    String url1 =
        'https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/$token/$id.json?auth=$token';
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
    }


    if (flag == 0) {
      response = await http.post(Uri.parse(url), body: json.encode(map));
    } else {
      response = await http.patch(Uri.parse(url1), body: json.encode(map));
    }

    print(response.statusCode);
    try {
      if (response.statusCode == 200) {
      } else {
      }
    } on Exception catch (e) {
      print(e);
    }

  }

  void search(String text) {
    txt = text;
    getFinalProducts();
  }

}


