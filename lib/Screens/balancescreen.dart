import 'package:bank_app/Screens/Transsection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class balancescreen extends StatefulWidget {
  const balancescreen({super.key});

  @override
  State<balancescreen> createState() => _balancescreenState();
}

class _balancescreenState extends State<balancescreen> {
  String userName = "";
  List<Map<String, String>> transactions =
      []; // List to store multiple transactions

  @override
  void initState() {
    super.initState();
    loadName();
    loadTransactions(); // Load all transactions
  }

  Future<void> loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'User';
    });
  }

  // Function to load multiple transactions from SharedPreferences
  Future<void> loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedTransactions = prefs.getStringList('transactions');

    print(storedTransactions); // Debugging: Check if transactions are loaded

    if (storedTransactions != null) {
      setState(() {
        transactions = storedTransactions.map((transactionString) {
          Map<String, String> transaction = {};
          List<String> details = transactionString.split(',');
          transaction['fbank'] = details[0];
          transaction['tbank'] = details[1];
          transaction['amount'] = details[2];
          transaction['message'] = details[3];
          return transaction;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Action for menu button
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action for notification button
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 330,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 70,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$userName',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Balance",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "\$1,234.56", // Replace with actual balance
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Transsection(),
                              ),
                            ).then((_) =>
                                loadTransactions()); // Refresh transactions on return
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text('Transfer'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Latest Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From Bank: ${transaction['fbank']}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "To Bank: ${transaction['tbank']}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Amount: \$${transaction['amount']}",
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Message: ${transaction['message']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
