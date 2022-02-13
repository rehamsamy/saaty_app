import 'package:flutter/material.dart';

import '../../cons.dart';

class TextFormProductData extends StatelessWidget {
  String flag, hint;
  IconData icon;
  TextInputType inputType;
  var _nameController,_priceController,_phoneController,
      _emailController,_descController;

  Map<String,dynamic> map={
    'name':'',
    'email':'',
    'price':'',
    'desc':'',
    'phone':'',
    'email':'',
    'creator_name':'',
    'images':[]
  };



  TextFormProductData(this.flag, this.hint, this.icon, this.inputType,this.map);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: buildControllerValues(flag),
      textAlign: TextAlign.start,
      maxLines: flag=='desc'?5:1,
      decoration: InputDecoration(
          prefixIcon: flag=='desc'? Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
            child: Icon(icon, color: Cons.primary_color),
          )
              : Icon(icon, color: Cons.primary_color),
          hintText: hint,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Cons.primary_color,
              width: 1.0,
            ),
          )
        // hoverColor: Theme.of(context).primaryColor,focusColor: Colors.amber
      ),
      validator: (value) {
        if (value.isEmpty&&flag=='name') {
          return 'enter name';
        } if (value.isEmpty&&flag=='price') {
          return 'enter price';
        } if (value.isEmpty&&flag=='desc') {
          return 'enter description';
        } if (value.isEmpty&&flag=='phone') {
          return 'enter phone';
        } if (value.isEmpty&&flag=='name') {
          return 'enter name';
        } if (value.isEmpty&&flag=='email') {
          return 'enter email';
        }
        if (!value.contains('.com') && flag == 'email') {
          return 'enter valid email';
        }

      },
      onSaved: (value) {
        //loginMap['password'] = value!;
        if (flag == 'name') {
          map['name'] = value;
        }
        if (flag == 'price') {
          map['price'] = value;
        }
        if (flag == 'phone') {
          map['phone'] = value;
        }
        if (flag == 'email') {
          map['email'] = value;
        }
        if (flag == 'desc') {
          map['desc'] = value;
        }
      },
      keyboardType: inputType,
    );
  }


  TextEditingController buildControllerValues(String flag){
    if(flag=='name'){
      return _nameController;
    }  if(flag=='price'){
      return _priceController;
    }  if(flag=='email'){
      return _emailController;
    }  if(flag=='desc'){
      return _descController;
    }  if(flag=='phone'){
      return _phoneController;
    } else
    {
      return null;
    }
  }


}
