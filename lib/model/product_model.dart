import 'package:flutter/cupertino.dart';

class Product{
  String name;
  String price;
  String desc;
  String email;
  String phone;
  String id;
  String creator_id;
  String creator_name;
  int cat;
  int status;
  int isFav;
  int connType;
  String dateTime;
  List<dynamic> images;

  Product({@required this.id,@ required this.name,@ required this.price,@ required this.desc, @ required this.email, @ required this.phone, @ required this.cat,
  @ required this.status,@ required  this.isFav, @ required this.images,@required this.connType,@required this.creator_id,
  @ required this.dateTime,@ required this.creator_name});


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
        connType:map['connType'],
        creator_id:map['creator_id'],
    dateTime: map['dataTime'],
    creator_name: map['creator_name']);
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
        'connType':p. connType,
      'dateTime':p.dateTime,
      'creator_name':p.creator_name
    };
  }

}