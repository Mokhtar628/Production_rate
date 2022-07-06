import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_rate/viewProducts.dart';
import 'package:product_rate/viewUsers.dart';
import 'AddUser.dart';
import 'Admin.dart';
import 'User.dart';


String InvalidStatement = "";
String validStatement = "";
Navigators navigator = new Navigators();

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

class Products {
  final String userName;
  final String product_code;
  final String date;
  final int production_rate;

  Products({this.userName, this.product_code, this.date,this.production_rate});


  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'product_code': product_code,
      'date': date,
      'production_rate': production_rate,
    };
  }
}

class Controllers{
  var nameCont = TextEditingController();
  var passCont = TextEditingController();
  var codeCont = TextEditingController();
  var rateCont = TextEditingController();
  var SearchCont = TextEditingController();
  var op_description = TextEditingController();
}

Future<void> CheckUsers(String name,String pass,BuildContext context) async{
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => User(name)));

    }
    else{
      wrong++;
      ctr++;
    }


  });
}

class Navigators{
  void addUserUI(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUser()));
  }

  void viewProductsUI(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewProducts()));
  }

  void viewUsersUI(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewUsers()));
  }

  void adminUI(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Admin("Hossam")));
  }


}