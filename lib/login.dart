import 'package:flutter/material.dart';
import 'package:product_rate/controllersAndNavigators.dart';
import 'AddInventory.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _passwordVisible = false;
  Controllers controllers = new Controllers();

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
            padding: const EdgeInsets.fromLTRB(40, 95, 40, 0),
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
                        controller: controllers.nameCont,
                        //save inputs
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        //input text color
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(39,67,89, 1.0),),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                            //  when the TextFormField in focused
                          ),
                          hintText: "الاسم",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.person,
                            color: Color. fromRGBO(39,67,89, 1.0),
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
                        controller: controllers.passCont,
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
                          hintText: "كلمة المرور",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          icon: Icon(
                            Icons.vpn_key,
                            color: Color. fromRGBO(39,67,89, 1.0),
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
                        if(controllers.nameCont.text=="" || controllers.passCont.text==""){
                          setState(() {
                            InvalidStatement="الرجاء ادخال جميع الحقول";
                          });
                        }else{
                          if(controllers.nameCont.text.trim()=="Hossam" && controllers.passCont.text=="2801"){
                            navigator.adminUI(context);
                          }else if(controllers.nameCont.text.trim()=="hashim"  && controllers.passCont.text=="1234"){
                            //navigator.addInventoryUI(context,controllers.nameCont.text.trim());
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddInventory("hashim")));

                          }
                          else if (controllers.nameCont.text.trim()=="ahmed" && controllers.passCont.text=="1234"){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddInventory("ahmed")));
                          }

                          CheckUsers(controllers.nameCont.text, controllers.passCont.text,context);
                          setState(() {
                            controllers.nameCont.text="";
                            controllers.passCont.text="";
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

