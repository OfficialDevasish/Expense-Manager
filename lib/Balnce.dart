import 'package:flutter/material.dart';

import 'helper/DatabaseHandler.dart';

class Balnce extends StatefulWidget {


  @override
  State<Balnce> createState() => _BalnceState();
}

class _BalnceState extends State<Balnce> {


  var totalincome=0.0,totalexpence=0.0,balance=0.0;

  getdata() async {
    DatabaseHandler obj = new DatabaseHandler();
    List alldata = await obj.getallexpense();
    for (var row in alldata) {
      if(row["typ"].toString()=="expense")
        {
          setState(() {
            totalexpence=totalexpence + double.parse(row["amount"].toString());
          });
        }
      else
        {
          setState(() {
            totalincome=totalincome + double.parse(row["amount"].toString());
          });
        }
      setState(() {
        balance= totalincome-totalexpence;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade300,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₹ "+totalexpence.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
                Text("₹ "+totalincome.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
              ],
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Text("₹ "+balance.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        )

      ),
    );
  }
}
