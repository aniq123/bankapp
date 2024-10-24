// ignore_for_file: prefer_const_constructors

import 'package:bank_app/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signIn_Screen extends StatefulWidget {
  const signIn_Screen({super.key});

  @override
  State<signIn_Screen> createState() => _signIn_ScreenState();
}

class _signIn_ScreenState extends State<signIn_Screen> {
  bool isChecked = false;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController accountcntroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  //function save savedata from shred_perefs
  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', namecontroller.text);
    prefs.setString('bankAccount', accountcntroller.text);
    prefs.setString('email', emailcontroller.text);
    prefs.setString('password', passwordcontroller.text);
    prefs.setBool('isChecked', isChecked);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      namecontroller.text = prefs.getString('name') ?? '';
      accountcntroller.text = prefs.getString('bankAccount') ?? '';
      emailcontroller.text = prefs.getString('email') ?? '';
      passwordcontroller.text = prefs.getString('password') ?? '';
      isChecked = prefs.getBool('isChecked') ?? false;
    });

    @override
    void initState() {
      super.initState();
      // Load saved data when the app starts
      loadData();
    }

    // Validate input fields (simple validation for non-empty fields)
  }

  bool _isValidData() {
    return namecontroller.text.isNotEmpty &&
        accountcntroller.text.isNotEmpty &&
        emailcontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                // Image at the top
                child: Image.asset(
                  "assets/1000_F_596241802_e6Usv2nE50jeE0zv4y2HL9b8zVgpacHy-removebg-preview.png",
                ),
              ),
              Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "Enter Your Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: accountcntroller,
                          decoration: InputDecoration(
                            labelText: "Bank Account",
                            hintText: "Enter Your Account Number",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "Enter Your Email Address",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "Enter Your Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Use a mix of letters, symbols, and numbers",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    SizedBox(height: 5),
                    // Checkbox and associated text
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                        Text(
                            "By Signing you agree  to bank \n terms of bank & privacy policy  ")
                        // if (isChecked) ...[
                        //   Icon(Icons.check, color: Colors.green),
                        //   SizedBox(width: 10),
                        //   Text(
                        //     'Checkbox clicked!',
                        //     style: TextStyle(color: Colors.green),
                        //   ),
                        // ]
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_isValidData()) {
                                // Call a function to check if data is valid
                                saveData(); // Save data locally
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginScreen()),
                                );
                              } else {
                                // Show error message (You can use a SnackBar or dialog for this)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Invalid Data. Please check your inputs.")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Sign UP",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text("OR"),
                        ),
                        Container(
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('Alredy Signed up?'),
                        Align(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              loginScreen())));
                                },
                                child: Text(
                                  'LogIn',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blueAccent),
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
