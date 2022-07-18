import 'package:flutter/material.dart';

class SearchedInventory extends StatefulWidget {
  String name ,code,date;
  int rate;
  SearchedInventory(String name,String code,String date,int rate){
    this.name=name;
    this.code=code;
    this.date=date;
    this.rate=rate;
  }
  @override
  _SearchedInventoryState createState() => _SearchedInventoryState(name,code,date,rate);
}

class _SearchedInventoryState extends State<SearchedInventory> {
  String name ,code,date;
  int rate;
  _SearchedInventoryState(String this.name,String this.code,String this.date,int this.rate);
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
                                gradient: LinearGradient(colors: [Color. fromRGBO(31,52,67, 1.0),
                                  Color. fromRGBO(39,67,89, 1.0),
                                  Color. fromRGBO(48,80,103, 1.0)]),
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
                                        Text("Product code : "+code,style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Received products : $rate",style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Date : "+date,style: TextStyle(color: Colors.white),)
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


