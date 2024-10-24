// ignore_for_file: prefer_const_constructors

import 'package:bank_app/Screens/balancescreen.dart';
import 'package:flutter/material.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => balancescreen()));
              },
              icon: Icon(Icons.arrow_back)),
          SizedBox(
            width: 60,
          ),
          Padding(
            padding: EdgeInsets.only(right: 60),
            child: Title(
                color: Colors.white,
                child: Text(
                  "Account",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
    );
  }
}
