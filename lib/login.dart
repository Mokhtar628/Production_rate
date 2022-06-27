import 'package:flutter/material.dart';
import 'package:product_rate/controllersAndNavigators.dart';

import 'Admin.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('تسجيل الدخول'),
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
                          hintText: "الاسم",
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
                        obscureText: !_passwordVisible,
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
                          hintText: "كلمة المرور",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.purple,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),//pass

                    RaisedButton(
                      onPressed: () {
                        if(nameCont.text=="" || passCont.text==""){
                          setState(() {
                            InvalidStatement="الرجاء ادخال جميع الحثول";
                          });
                        }else{
                          if(nameCont.text.trim()=="Hossam" && passCont.text=="2801"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Admin("Hossam")));
                          }

                          CheckUsers(nameCont.text, passCont.text,context);
                          setState(() {
                            nameCont.text="";
                            passCont.text="";
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
                        const Text('تسجيل الدخول', style: TextStyle(fontSize: 20)),
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

