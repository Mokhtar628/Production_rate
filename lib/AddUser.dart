import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  String InvalidStatement="";
  //function to add data to firebase
  void addData(String name,String pass){
    DatabaseReference _ref;
    _ref=FirebaseDatabase.instance.reference().child("users");
    _ref.push().set({'name':name.trim(),'password':pass,'productionCtr':0});
  }
  //-------------------------------
  String dropdownValue;
  var nameCont = TextEditingController();
  var passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Add users'),
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
                          maxLength: 30,
                          controller: nameCont,
                          //save inputs
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          //input text color
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purpleAccent),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amberAccent),
                              //  when the TextFormField in focused
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.person,
                              color: Colors.purple,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),//name

                      Container(
                        margin: EdgeInsets.all(12.0),
                        child: TextField(
                          maxLength: 30,
                          controller: passCont,
                          //save inputs
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          //input text color
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purpleAccent),
                              //  when the TextFormField in unfocused
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amberAccent),
                              //  when the TextFormField in focused
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.purple,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),//pass



                      RaisedButton(
                        onPressed: () {
                          if(nameCont.text=="" || passCont.text==""){
                            setState(() {
                              InvalidStatement="Please enter all fields!!";
                            });
                          }else{
                            addData(nameCont.text, passCont.text);
                            setState(() {
                              nameCont.text = "";
                              passCont.text = "";
                              InvalidStatement="Added successfully";
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
                                Colors.deepPurple,
                                Colors.purple,
                                Colors.purpleAccent,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child:
                          const Text('Submit', style: TextStyle(fontSize: 20)),
                        ),
                      ),
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
