import 'dart:convert';


import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:http/http.dart' as http;

import '../cons.dart';
import 'auth_controller.dart';

class StatusProductController extends GetxController{
  List<Product> _allProds = [];
  List<Product> _favProducts = [];
  List<Product> filteredList = [];
  int filterRad = 0;
  bool statusOldChecked = false;
  bool statusNewChecked = false;
  String txt=null;
  bool isFiltering = false;

  int selectedTabIndex =1;

  String token = AuthController.token;
  String userId = AuthController.userId;

  List<Product> get allProducts {
    return _allProds;
  }
  List<Product> get favProducts {
    return _favProducts;
  }

  List<Product> get newProductsList {
    return _allProds.where((element) => element.status == 0).toList();
  }

  List<Product> get oldProductsList {
    return _allProds.where((element) => element.status == 1).toList();
  }


  Future fetchProducts(String flag,String id) async {
    print('bbbb  '+id +'  ');
    allProducts.clear();
    favProducts.clear();
    String token = AuthController.token;
    print(AuthController.userId);
    String urlFav='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${AuthController.userId}.json?auth=$token';
    String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=$token';
    try {

      var favResponse=await http.get(Uri.parse(urlFav));
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> result =
        json.decode(response.body) as Map<String, dynamic>;
        var favResult=  json.decode(favResponse.body) as Map<String, dynamic>;
        if (flag == 'all') {
          result.forEach((key, value) async {
            Product product = Product.fromJson(key, value);
            if(favResponse.statusCode==200){
              print('************* here ');
              product.isFav=favResult[key];
            }else{
              product.isFav=0;
            }
            if(value['id']==id) {
              print('bbbb  '+id +'  '+value['id']);
              _allProds.add(product);
            }

          });
        }
        print('bbbb  '+id +'  '+'  ');
        getFinalProducts();
      }

    } catch (err) {
      print(err);
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


  void getFinalProducts() {
    print('flag  ' + selectedTabIndex.toString());
    if (txt.isEmpty) {
      if (isFiltering == false) {
        if (selectedTabIndex == 0 ) {
          filteredList =newProductsList;
        } else   if (selectedTabIndex == 1 ) {
          filteredList = oldProductsList;
        }
      } else {
        if (selectedTabIndex == 0 &&
            filterRad == 0 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = newProductsList;
          filteredList = Cons.selectionDescSortFilter(newList);
        } else if (selectedTabIndex == 0 &&
            filterRad == 1 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = newProductsList;
          filteredList = Cons.selectionAsecSortFilter(newList);
        }
        else if (selectedTabIndex == 1 &&
            filterRad == 1 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = oldProductsList;
          filteredList = Cons.selectionAsecSortFilter(newList);
        } else if (selectedTabIndex == 1 &&
            filterRad == 0 &&
            statusOldChecked == true &&
            statusNewChecked == true) {
          List<Product> newList = [];
          newList = oldProductsList;
          filteredList = Cons.selectionDescSortFilter(newList);
        }
        //else if (selectedTabIndex == 2 &&
        //     filterRad == 1 &&
        //     statusOldChecked == true &&
        //     statusNewChecked == true) {
        //   List<Product> newList = [];
        //   newList = bracletesProductsList;
        //   filteredList = Cons.selectionAsecSortFilter(newList);
        // } else if (selectedTabIndex == 2 &&
        //     filterRad == 0 &&
        //     statusOldChecked == true &&
        //     statusNewChecked == true) {
        //   List<Product> newList = [];
        //   newList = bracletesProductsList;
        //   filteredList = Cons.selectionDescSortFilter(newList);
        // }
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
    print('selllllllllllll  '+allProducts.length.toString());
    if (selectedTabIndex == 0) {
      return newProductsList
          .where((element) => element.name.contains(text))
          .toList();
    }else if (selectedTabIndex == 1) {
      return oldProductsList
          .where((element) => element.name.contains(text))
          .toList();
    }
  }


  void search(String text) {
    txt = text;
    getFinalProducts();
  }
}