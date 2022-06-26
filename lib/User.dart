import 'package:flutter/material.dart';

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
      child: Text(name),
    );
  }
}
