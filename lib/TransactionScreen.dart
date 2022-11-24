import 'package:flutter/material.dart';
import 'package:untitled1/ExpenseUpdate.dart';
import 'package:untitled1/helper/DatabaseHandler.dart';

import 'Balnce.dart';
import 'PersonalExpense.dart';

class TransactionScreen extends StatefulWidget {

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {

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
    return FutureBuilder(
      future: alldata,
      builder: (context, snapshots) {
        if (snapshots.hasData) {
          if (snapshots.data.length <= 0) {
            return Center(
              child: Text("No Data Avaialaable"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshots.data.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  elevation: 20,
                  color: (snapshots.data[index]["typ"].toString() ==
                      "expense")
                      ? Colors.red.shade100
                      : Colors.green.shade100,
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            "₹" +
                                snapshots.data[index]["amount"]
                                    .toString(),
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          snapshots.data[index]["expense_head"]
                              .toString().toUpperCase(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "" +
                              snapshots.data[index]["descp"]
                                  .toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Date:" +
                              snapshots.data[index]["dat"].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                var eid = snapshots.data[index]["eid"]
                                    .toString();

                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ExpenseUpdate(
                                              updateid: eid,
                                            )));
                              },
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      2.2,
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  )),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(1),
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                AlertDialog alert = AlertDialog(
                                  title: Text(
                                    "Are You Sure ",
                                    style:
                                    TextStyle(color: Colors.red),
                                  ),
                                  content:
                                  Text("This Expense Has delete"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        var eid = snapshots
                                            .data[index]["eid"]
                                            .toString();
                                        DatabaseHandler obj =
                                        new DatabaseHandler();
                                        var status =
                                        obj.deleteExpense(eid);

                                        Navigator.of(context).pop();
                                        getdata();
                                      },
                                      child: Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No"),
                                    ),
                                  ],
                                );

                                // show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    2.2,
                                padding: EdgeInsets.all(10),
                                color: Colors.red,
                                child: Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );

                // ListTile(
                //   title:
                //   subtitle:
                // );
              },
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
