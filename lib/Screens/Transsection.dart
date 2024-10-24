// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bank_app/Screens/balancescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Transsection extends StatefulWidget {
  const Transsection({super.key});

  @override
  State<Transsection> createState() => _TranssectionState();
}

class _TranssectionState extends State<Transsection> {
  TextEditingController frombankcontroller = TextEditingController();
  TextEditingController tobankcontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();

  // Store the input data in SharedPreferences
  Future<void> storedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transaction =
        '${frombankcontroller.text},${tobankcontroller.text},${amountcontroller.text},${messagecontroller.text}';
    List<String>? transactions = prefs.getStringList('transactions') ?? [];
    transactions.add(transaction);
    await prefs.setStringList('transactions', transactions);

    // Also store the individual fields for balance screen use
    prefs.setString('Fbank', frombankcontroller.text);
    prefs.setString('Tbank', tobankcontroller.text);
    prefs.setString('Amount', amountcontroller.text);
    prefs.setString('Message', messagecontroller.text);
  }

  @override
  void initState() {
    super.initState();
    // Clear the text fields when the screen is opened
    frombankcontroller.clear();
    tobankcontroller.clear();
    amountcontroller.clear();
    messagecontroller.clear();
  }

  // Validation for empty fields
  bool _isValidData() {
    return frombankcontroller.text.isNotEmpty &&
        tobankcontroller.text.isNotEmpty &&
        amountcontroller.text.isNotEmpty &&
        messagecontroller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => balancescreen()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          SizedBox(width: 30),
          Padding(
            padding: EdgeInsets.only(right: 60),
            child: Title(
              color: Colors.white,
              child: Text(
                'Transaction',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => balancescreen()));
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 300,
                child: Center(
                  child: Image(image: AssetImage("assets/trasection.png")),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                child: Container(
                  width: 270,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      _buildTextField(
                        controller: frombankcontroller,
                        label: 'From Bank Account',
                        hint: '123-1234-152-4',
                        icon: Icons.account_balance,
                      ),
                      SizedBox(height: 5),
                      _buildTextField(
                        controller: tobankcontroller,
                        label: 'To Bank Account',
                        hint: '123-1234-152-4',
                        icon: Icons.account_balance,
                      ),
                      SizedBox(height: 5),
                      _buildTextField(
                        controller: amountcontroller,
                        label: 'Amount',
                        hint: 'Enter Amount you want to send',
                        icon: Icons.monetization_on,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 5),
                      _buildTextField(
                        controller: messagecontroller,
                        label: 'Message',
                        hint: 'Enter Message',
                        icon: Icons.message,
                      ),
                      Row(
                        children: [
                          Container(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_isValidData()) {
                                  await storedata();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => balancescreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Invalid Data. Please check your inputs.",
                                      ),
                                    ),
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
                                "Send",
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => balancescreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 50,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
