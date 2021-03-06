import 'package:flutter/material.dart';

class searchedProduct extends StatefulWidget {
  String name ,code,date,op_desc,worker;
  int rate;
  searchedProduct(String name,String code,String date,int rate,String op_desc,String worker ){
    this.name=name;
    this.code=code;
    this.date=date;
    this.rate=rate;
    this.op_desc=op_desc;
    this.worker=worker;
  }
  @override
  _searchedProductState createState() => _searchedProductState(name,code,date,rate,op_desc,worker);
}

class _searchedProductState extends State<searchedProduct> {
  String name ,code,date,op_desc,worker;
  int rate;
  _searchedProductState(String this.name,String this.code,String this.date,int this.rate,String this.op_desc,String this.worker);
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
                              height: 120,
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
                                        Text("Production rate : $rate",style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Date : "+date,style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Operation description : "+op_desc,style: TextStyle(color: Colors.white),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Worker : "+worker,style: TextStyle(color: Colors.white),)
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


