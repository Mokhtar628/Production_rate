
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:http/http.dart' as http;
import 'package:product_rate/searchedUser.dart';
import 'dart:convert';

import 'controllersAndNavigators.dart';



class ViewUsers extends StatefulWidget {
  @override
  _ViewUsersState createState() => _ViewUsersState();
}

var SearchCont = TextEditingController();


class _ViewUsersState extends State<ViewUsers> {
  Query _ref;
  @override
  void initState() {
    //retrieve();
    super.initState();
    _ref=FirebaseDatabase.instance.reference().child("users");
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
                color: Colors.purple,
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
                        Colors.deepPurple,
                        Colors.purple,
                        Colors.purpleAccent
                      ])
              ),
            ),
          ),// app bar end here --------------------------

          body: Container(
            width: double.infinity,
            height: double.infinity,

            child: FirebaseAnimatedList(query: _ref,itemBuilder: (BuildContext context ,DataSnapshot snapshot,Animation<double>animation,int index){
              Map emp = snapshot.value;
              return userWidget(emp: emp);
            }),
          ),


      ),
    );
  }
}

Widget userWidget({Map emp})
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
                        gradient: LinearGradient(colors: [Colors.deepPurple,Colors.purple,Colors.purpleAccent]),
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
                                Text("Name : ${emp['name']}",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Password : ${emp['password']}",style: TextStyle(color: Colors.white),)
                              ],
                            ),
                            Row(
                              children: [
                                Text("Production counter : ${emp['productionCtr']}",style: TextStyle(color: Colors.white),)
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
        InputDecoration(border: InputBorder.none, hintText: 'Search user',contentPadding: EdgeInsets.fromLTRB(20,0,0,0),),
      ),
    );
  }
}

Future<void> searchfun(String text,BuildContext context) async{
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
  //_navigateToScreenAdmin(context,"user.name");
}

