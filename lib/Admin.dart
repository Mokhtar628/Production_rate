import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:product_rate/viewProducts.dart';
import 'package:product_rate/viewUsers.dart';
import 'package:product_rate/controllersAndNavigators.dart';
import 'AddUser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  String name;

  Admin(String name){
    this.name=name;
  }

  @override
  _AdminState createState() => _AdminState(name);
}

class _AdminState extends State<Admin> {
  String name;

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
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.once().then((DataSnapshot snapshot){
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

  _AdminState(String name){
    this.name=name;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

          appBar: AppBar(
            title: Text('Welcome Mr: '+name),
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
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(210, 0, 0, 0),
                  color:Color. fromRGBO(39,67,89, 1.0),
                  child: Text("Admin Field",style: TextStyle(color: Colors.white),),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 25,
                    padding: EdgeInsets.all(20),
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color. fromRGBO(39,67,89, 1.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("Add user",style: TextStyle(color: Colors.white,fontSize: 20)),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddUser()));
                        },
                      ),

                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color. fromRGBO(39,67,89, 1.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("View products",style: TextStyle(color: Colors.white,fontSize: 20,)),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewProducts()));
                        },
                      ),

                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color. fromRGBO(39,67,89, 1.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("Reset",style: TextStyle(color: Colors.white,fontSize: 20,)),
                        ),
                        onTap: () {
                          loopAndReset();
                        },
                      ),

                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color. fromRGBO(39,67,89, 1.0),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("View users",style: TextStyle(color: Colors.white,fontSize: 20,)),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewUsers()));
                        },
                      ),


                    ],

                  ),
                )

              ],
            ),
          ),


      ),
    );
  }
}
