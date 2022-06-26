import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';

var nameCont = TextEditingController();
var passCont = TextEditingController();
String InvalidStatement = "";


class Users {
  final String name;
  final String password;
  final int productionCtr;

  Users({this.name, this.password, this.productionCtr});


  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
      'productionCtr': productionCtr,
    };
  }
}


Future<void> CheckUsers(String name,String pass,BuildContext context) async{
  //_navigateToScreenAdmin(context,"user.name");
  final String url = "https://products-rate-default-rtdb.firebaseio.com/users.json";
  final http.Response res = await http.get(url);
  final data = json.decode(res.body) as Map<String, dynamic>;
  Users user;
  int wrong = 0,ctr=0;
  data.forEach((key, value) {
    user = Users(
        name: value["name"],
        password: value["password"] ,
        productionCtr: value["productionCtr"]
    );
    if(user.name.toLowerCase()==name.toLowerCase().trim() && user.password==pass){
      ctr++;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => User(user.name)));

    }
    else{
      wrong++;
      ctr++;
    }


  });
}
