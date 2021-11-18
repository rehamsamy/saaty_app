import 'package:flutter/cupertino.dart';

class Product{
  String name;
  String price;
  String desc;
  String email;
  String phone;
  String id;
  int cat;
  int status;
  int isFav;
  List<String> images;

  Product({@required this.id,@ required this.name,@ required this.price,@ required this.desc, @ required this.email, @ required this.phone, @ required this.cat,
  @ required this.status,@ required  this.isFav, @ required this.images});


  factory Product.fromJson(Map<String,dynamic> map){
    return Product(
        id:map['id'],
        name:map['name']
        ,price:map ['price']
        ,desc: map['desc']
        ,email: map['email']
        ,phone: map['phone'],
        cat:map['cat'],
        status:map['status'],
        isFav: map['isFav'],
        images:map['images']);
  }
}