
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/ExpenseMangerLoginPage.dart';

import 'ExpenseMangerHomePage.dart';
import 'PersonalExpense.dart';

class ExpenseMangerCreatePin extends StatefulWidget {


  @override
  State<ExpenseMangerCreatePin> createState() => _ExpenseMangerCreatePinState();
}

class _ExpenseMangerCreatePinState extends State<ExpenseMangerCreatePin> {

  TextEditingController _pin = TextEditingController();
  TextEditingController _confirmpin = TextEditingController();


  checklogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("pin"))
      {
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ExpenseMangerLoginPage()));
      }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: Center(
          child: Text("Ceate Pin",style: TextStyle(color: Colors.white),),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please Create Your Pin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
              SizedBox(height: 20,),
              Text("Pin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              TextField(
                controller: _pin,
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
              SizedBox(height: 15,),
              Text("Confirm Pin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              TextField(
                controller: _confirmpin,
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
              Center(
                child: ElevatedButton(
                  onPressed: ()async{

                    var pin =_pin.text.toString();
                    var confirmpin=_confirmpin.text.toString();

                    if(pin.length<=0)
                      {
                        Fluttertoast.showToast(
                            msg: "Plese Entere Your Pin",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.yellow,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      }
                    else if(confirmpin.length<=0)
                      {
                        Fluttertoast.showToast(
                            msg: "Plese Entere Your Confirm Pin",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else if(pin!=confirmpin)
                      {
                        Fluttertoast.showToast(
                            msg: "Your Pin And Confirm Pin Not Match",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    else
                      {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("pin", pin);

                        //SP
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>ExpenseMangerHomePage()));
                      }


                  },

                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                     // foreground
                  ),
                  child: Text("Submit"),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
