import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_rate/viewInventory.dart';
import 'package:product_rate/viewProducts.dart';
import 'package:product_rate/viewUsers.dart';
import 'AddInventory.dart';
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
  final String operation_description;
  final String worker;


  Products({this.userName, this.product_code, this.date,this.production_rate,this.operation_description,this.worker});


  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'product_code': product_code,
      'date': date,
      'production_rate': production_rate,
      'operation_description':operation_description,
      'worker':worker
    };
  }
}

class Inventoryproducts {
  final String userName;
  final String product_code;
  final String date;
  final int Recived_product;

  Inventoryproducts({this.userName, this.product_code, this.date,this.Recived_product});


  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'product_code': product_code,
      'date': date,
      'Recived_product': Recived_product,
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
  var codeInventory = TextEditingController();
  var numberInventory = TextEditingController();
  var worker = TextEditingController();


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

  void addInventoryUI(BuildContext context,String name){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddInventory(name)));
  }

  void viewInventoryUI(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewInventory()));
  }


}