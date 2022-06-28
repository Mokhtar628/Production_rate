import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:product_rate/controllersAndNavigators.dart';
import 'package:intl/intl.dart';

class User extends StatefulWidget {
  String name;

  User(String name){
    this.name=name;
  }

  @override
  _UserState createState() => _UserState(this.name);
}

class _UserState extends State<User> {
  String name;

  void addData(String name,String productCode,int productRate, String date){
    DatabaseReference _ref;
    _ref=FirebaseDatabase.instance.reference().child("products");
    _ref.push().set({'userName':name.trim(),'product_code':productCode.trim(),'production_rate':productRate,'date':date});
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
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.once().then((DataSnapshot snapshot){
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

  _UserState(String name){
    this.name=name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('اضافة معدل انتاج'),
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 130, 40, 0),
              child: SingleChildScrollView(

                child: Container(
                  height: 400,
                  alignment: Alignment.center,
                  color: Color(0x70000000),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(12.0),
                        child: TextField(
                          controller: codeCont,
                          //save inputs
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          //input text color
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color. fromRGBO(39,67,89, 1.0)),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amberAccent),
                              //  when the TextFormField in focused
                            ),
                            hintText: "كود المنتج",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.qr_code,
                              color: Color. fromRGBO(39,67,89, 1.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),//name

                      Container(
                        margin: EdgeInsets.all(12.0),
                        child: TextField(
                          controller: rateCont,
                          //save inputs
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          //input text color
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color. fromRGBO(39,67,89, 1.0)),

                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amberAccent),
                              //  when the TextFormField in focused
                            ),
                            hintText: "معدل الانتاج",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.precision_manufacturing_outlined,
                              color: Color. fromRGBO(39,67,89, 1.0),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),//pass

                      RaisedButton(
                        onPressed: () {
                          if(codeCont.text=="" || rateCont.text==""){
                            setState(() {
                              InvalidStatement="الرجاء ادخال كل الحقول";
                              validStatement="";
                            });
                          }else{
                            addData(this.name,codeCont.text, int.parse(rateCont.text),DateFormat("yyyy-MM-dd").format(DateTime.now()));
                            searchAndIncreament(this.name);
                            setState(() {
                              codeCont.text="";
                              rateCont.text="";
                              validStatement="تم اضافة المنتج";
                              InvalidStatement="";
                            });
                          }
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: 235,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.red,
                                Colors.redAccent,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child:
                          const Text('اضافة', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Text(validStatement,style: TextStyle(color: Colors.green),),
                      Text(InvalidStatement,style: TextStyle(color: Colors.red),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
