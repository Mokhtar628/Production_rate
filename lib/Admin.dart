import 'package:flutter/material.dart';

import 'AddUser.dart';


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
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(210, 0, 0, 0),
                  color: Colors.purpleAccent,
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
                            color: Colors.purple,
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
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("Download rate",style: TextStyle(color: Colors.white,fontSize: 20,)),
                        ),
                        onTap: () {

                        },
                      ),

                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("Reset",style: TextStyle(color: Colors.white,fontSize: 20,)),
                        ),
                        onTap: () {

                        },
                      ),

                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white,spreadRadius: 0.5),
                            ],
                          ),
                          child: Text("View users",style: TextStyle(color: Colors.white,fontSize: 20,)),
                        ),
                        onTap: () {

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
