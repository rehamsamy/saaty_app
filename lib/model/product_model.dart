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
  int connType;
  List<dynamic> images;

  Product({@required this.id,@ required this.name,@ required this.price,@ required this.desc, @ required this.email, @ required this.phone, @ required this.cat,
  @ required this.status,@ required  this.isFav, @ required this.images,@required this.connType});


  factory Product.fromJson(String prodId,Map<String,dynamic> map){
    return Product(
        id:prodId,
        name:map['name']
        ,price:map ['price']
        ,desc: map['desc']
        ,email: map['email']
        ,phone: map['phone'],
        cat:map['cat'],
        status:map['status'],
        isFav: map['isFav'],
        images:map['images'],
        connType:map['connType']);
  }

  Map<String, dynamic> toMap(Product p) {
    return {
      'id' :p.id,
      'name':p. name,
      'price':p. price,
      'desc' :p. desc,
      'email': p. email,
       'phone':p. phone,
        'cat':p. cat,
        'status':p. status,
        'isFav': p. isFav,
        'images':p. images,
        'connType':p. connType
    };
  }

}