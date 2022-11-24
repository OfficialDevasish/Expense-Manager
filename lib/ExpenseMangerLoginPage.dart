import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/ExpenseMangerCreatePin.dart';
import 'package:untitled1/ExpenseMangerHomePage.dart';

class ExpenseMangerLoginPage extends StatefulWidget {


  @override
  State<ExpenseMangerLoginPage> createState() => _ExpenseMangerLoginPageState();
}

class _ExpenseMangerLoginPageState extends State<ExpenseMangerLoginPage> {

  TextEditingController _enterpin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: Center(
          child: Text("Enter Your Pin",style: TextStyle(color: Colors.white,fontSize: 25),),
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Enter your pin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo),),
              TextField(
                controller: _enterpin,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20,),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      if(_enterpin.text.toString() == prefs.getString("pin"))
                        {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ExpenseMangerHomePage())
                          );
                        }
                      else
                        {
                          Fluttertoast.showToast(
                              msg: "Pin Not Match",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.yellow,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }



                    },

                    child: Text("Submit"),
                  ),
                  ElevatedButton(
                    onPressed: ()async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>ExpenseMangerCreatePin())
                      );
                    },

                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,),
                    child: Text("Logout"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
