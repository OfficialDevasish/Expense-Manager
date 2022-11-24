import 'package:flutter/material.dart';
import 'package:untitled1/ExpenseUpdate.dart';
import 'package:untitled1/TransactionScreen.dart';
import 'package:untitled1/helper/DatabaseHandler.dart';

import 'Balnce.dart';
import 'PersonalExpense.dart';

class ExpenseMangerHomePage extends StatefulWidget {
  @override
  State<ExpenseMangerHomePage> createState() => _ExpenseMangerHomePageState();
}

class _ExpenseMangerHomePageState extends State<ExpenseMangerHomePage> {
  Future<List> alldata;

  getdata() async {
    DatabaseHandler obj = new DatabaseHandler();
    setState(() {
      alldata = obj.getallexpense();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.shade400,
            title: Center(
              child: Text("Expense Manager"),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Transactions"),
                  icon: Icon(Icons.home),
                ),
                Tab(
                  child: Text("Balance"),
                  icon: Icon(Icons.money),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
              TransactionScreen(),
              Balnce()
          ]),
          floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.add),
              backgroundColor: Colors.blue.shade400,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PersonalExpense()));
              })),
    );
  }
}
