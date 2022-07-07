import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_rate/searchedProduct.dart';
import 'package:product_rate/searchedUser.dart';
import 'controllersAndNavigators.dart';

UsersChild usersChild = new UsersChild(FirebaseDatabase.instance.reference().child("users"));
ProductsChild productsChild = new ProductsChild(FirebaseDatabase.instance.reference().child("products"));
Controllers controllers = new Controllers();
InventoryChild inventoryChild = new InventoryChild(FirebaseDatabase.instance.reference().child("inventory"));



abstract class FireBaseController{
  DatabaseReference connection;
}

class UsersChild extends FireBaseController{

  UsersChild(DatabaseReference connection){
    super.connection = connection;
  }

  void add(String name,String pass){
    connection.push().set({'name':name.trim(),'password':pass,'productionCtr':0});
  }

  Future<void> searchAndIncreament(String name) async{
    final String url = "https://products-rate-default-rtdb.firebaseio.com/users.json";
    final http.Response res = await http.get(url);
    final data = json.decode(res.body) as Map<String, dynamic>;
    Users user;
    data.forEach((key, value) {
      user = Users(
          name: value["name"],
          password: value["password"] ,
          productionCtr: value["productionCtr"]
      );
      if(user.name.toLowerCase()==name.trim().toLowerCase()){
        increamentPerformanceCtr(user.name,user.password,user.productionCtr);
      }
    });
  }

  Future<void> increamentPerformanceCtr(String name,String pass, int productionCtr) async{
    var id;
    connection.once().then((DataSnapshot snapshot){
      snapshot.value.forEach((key,values) async {
        if(values['name']==name){
          id= key;
          final String url = "https://products-rate-default-rtdb.firebaseio.com/users/$id.json";
          var res = await http.patch(url,body: json.encode({
            "name": name,
            "password": pass,
            "productionCtr":productionCtr+1
          }));
        }
      });
    });
  }

  Future<void> loopAndReset() async{
    final String url = "https://products-rate-default-rtdb.firebaseio.com/users.json";
    final http.Response res = await http.get(url);
    final data = json.decode(res.body) as Map<String, dynamic>;
    Users user;
    data.forEach((key, value) {
      user = Users(
          name: value["name"],
          password: value["password"] ,
          productionCtr: value["productionCtr"]
      );
      resetPerformanceCtr(user.name,user.password,user.productionCtr);
    });
  }

  Future<void> resetPerformanceCtr(String name,String pass, int productionCtr) async{
    var id;
    connection.once().then((DataSnapshot snapshot){
      snapshot.value.forEach((key,values) async {
        if(values['name']==name){
          id= key;
          final String url = "https://products-rate-default-rtdb.firebaseio.com/users/$id.json";
          var res = await http.patch(url,body: json.encode({
            "name": name,
            "password": pass,
            "productionCtr":0
          }));
        }
      });
    });
  }

  Future<void> search(String text,BuildContext context) async{
    final String url = "https://products-rate-default-rtdb.firebaseio.com/users.json";
    final http.Response res = await http.get(url);
    final data = json.decode(res.body) as Map<String, dynamic>;
    Users user;
    data.forEach((key, value) {
      user = Users(
          name: value["name"],
          password: value["password"] ,
          productionCtr: value["productionCtr"]
      );
      if(user.name.toLowerCase()==text.trim().toLowerCase()){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchedEmp(value["name"],value["password"],value["productionCtr"])));
      }
    });
  }

}

class ProductsChild extends FireBaseController{

  ProductsChild(DatabaseReference connection){
    super.connection = connection;
  }

  void add(String name,String productCode,int productRate, String date, String op_description){
    connection.push().set({'userName':name.trim(),'product_code':productCode.trim(),'production_rate':productRate,'date':date, 'operation_description':op_description});
  }

  Future<void> search(String text,BuildContext context) async{
    final String url = "https://products-rate-default-rtdb.firebaseio.com/products.json";
    final http.Response res = await http.get(url);
    final data = json.decode(res.body) as Map<String, dynamic>;
    Products products;
    data.forEach((key, value) {
      products = Products(
          userName: value["userName"],
          product_code: value["product_code"] ,
          production_rate: value["production_rate"],
          date: value["date"]
      );
      if(products.product_code.toLowerCase()==text.trim().toLowerCase()){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchedProduct(value["userName"],value["product_code"],value["date"],value["production_rate"])));
      }
    });
  }
}
class InventoryChild extends FireBaseController{
  InventoryChild(DatabaseReference connection){
    super.connection = connection;
  }

  void add(String productCode,int recivedProduct,String name){
    connection.push().set({'userName':name.trim(),'product_code':productCode.trim(),'Recived_product':recivedProduct,'date':DateFormat("yyyy-MM-dd").format(DateTime.now()),});
  }

  Future<void> search(String text,BuildContext context) async{
    final String url = "https://products-rate-default-rtdb.firebaseio.com/inventory.json";
    final http.Response res = await http.get(url);
    final data = json.decode(res.body) as Map<String, dynamic>;
    Inventoryproducts products;
    data.forEach((key, value) {
      products = Inventoryproducts(
          userName: value["userName"],
          product_code: value["product_code"] ,
          Recived_product: value["Recived_product"],
          date: value["date"]
      );
      if(products.product_code.toLowerCase()==text.trim().toLowerCase()){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => searchedProduct(value["userName"],value["product_code"],value["date"],value["Recived_product"])));
      }
    });
  }
}