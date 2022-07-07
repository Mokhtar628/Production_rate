import 'package:flutter/material.dart';
import 'fireBaseController.dart';

class AddInventory extends StatefulWidget {
  String name;

  AddInventory (String name){
    this.name=name;
  }

  @override
  _AddInventoryState createState() => _AddInventoryState(this.name);
}

class _AddInventoryState extends State<AddInventory> {
  String InvalidStatement="";
  String validStatement="";
  String dropdownValue;
  String name;

  _AddInventoryState(String name){
    this.name=name;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('المخازن'),
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
                        maxLength: 30,
                        controller: controllers.codeInventory,
                        //save inputs
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        //input text color
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:  Color. fromRGBO(39,67,89, 1.0),),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
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
                        maxLength: 30,
                        controller: controllers.numberInventory,
                        //save inputs
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        //input text color
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color. fromRGBO(39,67,89, 1.0),),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            //  when the TextFormField in focused
                          ),
                          hintText: "الكمية المستلمة",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.add_business_outlined,
                            color:
                            Color. fromRGBO(39,67,89, 1.0),

                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),//pass



                    RaisedButton(
                      onPressed: () {
                        if(controllers.codeInventory.text=="" || controllers.numberInventory.text==""){
                          setState(() {
                            InvalidStatement="الرجاء ادخال كل الحقول";
                            validStatement="";
                          });
                        }else{
                          inventoryChild.add(controllers.codeInventory.text, int.parse(controllers.numberInventory.text),this.name);
                          setState(() {
                            controllers.codeInventory.text = "";
                            controllers.numberInventory.text = "";
                            validStatement="تم الادخال بنجاح";
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
                              Color. fromRGBO(31,52,67, 1.0),
                              Color. fromRGBO(39,67,89, 1.0),
                              Color. fromRGBO(48,80,103, 1.0)
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child:
                        const Text('ادخال', style: TextStyle(fontSize: 20)),
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
    );
  }
}

