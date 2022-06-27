

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchedEmp extends StatefulWidget {
  String name ,pass;
  int productCtr;
  searchedEmp(String name,String pass,int ctr){
    this.name=name;
    this.pass=pass;
    this.productCtr=ctr;
  }
  @override
  _searchedEmpState createState() => _searchedEmpState(name,pass,productCtr);
}

class _searchedEmpState extends State<searchedEmp> {
  String name ,pass;
  int productCtr;
  _searchedEmpState(String this.name,String this.pass,int this.productCtr);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

          body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                              //alignment: Alignment.center,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Colors.deepPurple,Colors.purple,Colors.purpleAccent]),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Name : "+name,style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Password : "+pass,style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Production counter : $productCtr",style: TextStyle(color: Colors.white),)
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
            ),
          ),
        ));
  }

}


