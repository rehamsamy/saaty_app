

import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/storage_controller.dart';
import 'dart:convert';


class FavsAdsController extends GetxController{

  StorageController _storageController=Get.find();
  List<Product> _allProds = [];
  List<Product> filteredList = [];

  bool statusOldChecked = false;
  bool statusNewChecked = false;
  String txt=null;
  bool isFiltering = false;
  bool isLoading = true;
  String prodTypeFlag=null;


  List<Product> get allProducts {
    return _allProds;
  }


  Future fetchProducts(String flag) async {
    allProducts.clear();
    _allProds.clear();
    String urlFav='https://saaty-9ba9f-default-rtdb.firebaseio.com/favorites/${StorageController.getString(StorageController.userId)}.json?auth=${StorageController.getString(StorageController.apiToken)}';
    String  url = 'https://saaty-9ba9f-default-rtdb.firebaseio.com/products.json?auth=${StorageController.getString(StorageController.apiToken)}';
    try {
      var favResponse=await http.get(Uri.parse(urlFav));
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> result =
        json.decode(response.body) as Map<String, dynamic>;
        var favResult=  json.decode(favResponse.body) as Map<String, dynamic>;
      if(flag=='fav'){
          result.forEach((key, value) async {
            Product product = Product.fromJson(key, value);
            product.isFav=favResult[key];
            if(product.isFav==1) {
              _allProds.add(product);
              // _favProducts.add(product);
            }
          });

        }
        else if(flag=='ads'){
          result.forEach((key, value) async {
            Product product = Product.fromJson(key, value);

            if (favResponse.statusCode == 200) {
              if (!favResponse.body.isEmpty) {
                product.isFav = favResult[key];
              } else {
                product.isFav = 0;
              }
            }
            if(value['id']==StorageController.getString(StorageController.userId)) {
              print('yes '+StorageController.getString(StorageController.userId));
              _allProds.add(product);

            }


          });
        }

        getFinalProducts();
      }

    } catch (err) {
      print(err);
    }

  }



  void getFinalProducts() {
    print('flag  ' + isFiltering.toString());
    print('cccccccccc'+txt);
    if (txt.isEmpty) {
      print('strep1');
      if (isFiltering == false) {
        print('strep2');
        if (prodTypeFlag == 'fav') {
          print('strep3');
          filteredList = _allProds;
        }else if (prodTypeFlag == 'ads') {
          filteredList = _allProds;
          print('strep4');
        }
        print('cccccccccc'+allProducts.length.toString());
        print('strep5');

      } else {
        print('cccccccccc');
        // if (selectedTabIndex == 0 &&
        //     filterRad == 0 &&
        //     statusOldChecked == true &&
        //     statusNewChecked == true) {
        //   List<Product> newList = [];
        //   newList = allProducts;
        //   filteredList = Cons.selectionDescSortFilter(newList);
        // } else if (selectedTabIndex == 0 &&
        //     filterRad == 1 &&
        //     statusOldChecked == true &&
        //     statusNewChecked == true) {
        //   List<Product> newList = [];
        //   newList = allProducts;
        //   filteredList = Cons.selectionAsecSortFilter(newList);
        // } else if (selectedTabIndex == 1 &&
        //     filterRad == 1 &&
        //     statusOldChecked == true &&
        //     statusNewChecked == true) {
        //   List<Product> newList = [];
        //   newList = watchProductsList;
        //   filteredList = Cons.selectionAsecSortFilter(newList);
        // } else if (selectedTabIndex == 1 &&
        //     filterRad == 0 &&
        //     statusOldChecked == true &&
        //     statusNewChecked == true) {
        //   List<Product> newList = [];
        //   newList = watchProductsList;
        //   filteredList = Cons.selectionDescSortFilter(newList);
        // } else if (selectedTabIndex == 2 &&
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
    print('text  '+text);
    if(prodTypeFlag=='fav'){
      return _allProds
          .where((element) => element.name.contains(text))
          .toList();
    }else  if(prodTypeFlag=='ads'){
      return _allProds
          .where((element) => element.name.contains(text))
          .toList();
    }
  }

  changeIsLoadingFlag(bool value) async {
    isLoading = value;
     update();
    //getFinalProducts();
  }

  void search(String text) {
    print('texx  '+text);
   this. txt = text;
    getFinalProducts();
  }



}