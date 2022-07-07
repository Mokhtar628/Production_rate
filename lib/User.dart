import 'package:flutter/material.dart';
import 'package:product_rate/controllersAndNavigators.dart';
import 'package:intl/intl.dart';
import 'package:product_rate/fireBaseController.dart';

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
            //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)/100,

            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 90, 40, 0),

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
                          controller: controllers.codeCont,
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
                          controller: controllers.rateCont,
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
                      ),

                      Container(
                        margin: EdgeInsets.all(12.0),
                        child: TextField(
                          controller: controllers.op_description,
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
                            hintText: "وصف العملية",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.precision_manufacturing_outlined,
                              color: Color. fromRGBO(39,67,89, 1.0),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      RaisedButton(
                        onPressed: () {
                          if(controllers.codeCont.text=="" || controllers.rateCont.text=="" || controllers.op_description.text==""){
                            setState(() {
                              InvalidStatement="الرجاء ادخال كل الحقول";
                              validStatement="";
                            });
                          }else{
                            productsChild.add(this.name,controllers.codeCont.text, int.parse(controllers.rateCont.text),DateFormat("yyyy-MM-dd").format(DateTime.now()),controllers.op_description.text);
                            usersChild.searchAndIncreament(this.name);
                            setState(() {
                              controllers.codeCont.text="";
                              controllers.rateCont.text="";
                              controllers.op_description.text="";
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
