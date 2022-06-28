
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:http/http.dart' as http;
import 'package:product_rate/searchedProduct.dart';
import 'package:product_rate/searchedUser.dart';
import 'dart:convert';

import 'controllersAndNavigators.dart';



class ViewProducts extends StatefulWidget {
  @override
  _ViewProductsState createState() => _ViewProductsState();
}

var SearchCont = TextEditingController();


class _ViewProductsState extends State<ViewProducts> {
  Query _ref;
  @override
  void initState() {
    //retrieve();
    super.initState();
    _ref=FirebaseDatabase.instance.reference().child("products");
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          titleSpacing: 0,
          title: TextBox(),
          actions: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              onPressed: () {
                setState(() {
                  searchfun(SearchCont.text,context);
                });
              },
              child: Icon(Icons.search),
            ),
          ],

          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color. fromRGBO(31,52,67, 1.0),
                      Color. fromRGBO(39,67,89, 1.0),
                      Color. fromRGBO(48,80,103, 1.0)
                    ])
            ),
          ),
        ),// app bar end here --------------------------

        body: Container(
          width: double.infinity,
          height: double.infinity,

          child: FirebaseAnimatedList(query: _ref,itemBuilder: (BuildContext context ,DataSnapshot snapshot,Animation<double>animation,int index){
            Map product = snapshot.value;
            return userWidget(product: product);
          }),
        ),


      ),
    );
  }
}

Widget userWidget({Map product})
{
  if(true){//SearchCont.text == emp['name']
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      width: 280,
                      height: 90,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color. fromRGBO(31,52,67, 1.0),
                          Color. fromRGBO(39,67,89, 1.0),
                          Color. fromRGBO(48,80,103, 1.0)]),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("User name : ${product['userName']}",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Product code : ${product['product_code']}",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Production rate : ${product['production_rate']}",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Date : ${product['date']}",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      height: 80,
      child: TextField(
        controller: SearchCont,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Search product',contentPadding: EdgeInsets.fromLTRB(20,0,0,0),),
      ),
    );
  }
}

Future<void> searchfun(String text,BuildContext context) async{
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
  //_navigateToScreenAdmin(context,"user.name");
}

