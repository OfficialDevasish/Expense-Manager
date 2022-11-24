import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/date_picker_theme.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ExpenseMangerHomePage.dart';
import 'package:untitled1/ExpenseMangerLoginPage.dart';
import 'package:untitled1/helper/DatabaseHandler.dart';

class PersonalExpense extends StatefulWidget {


  @override
  State<PersonalExpense> createState() => _PersonalExpenseState();
}

class _PersonalExpenseState extends State<PersonalExpense> {


  TextEditingController _head = TextEditingController();
  TextEditingController _descp = TextEditingController();
  TextEditingController _ammount = TextEditingController();



String time = '?';

  var _typ="income";
  TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.purple.shade400,
        title: Center(
          child: Text("Transaction Entry"),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _head,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, ),
                      ),
                    ),

                    keyboardType: TextInputType.text,

                  ),
                  SizedBox(height: 25,),
                  Text("Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  TextField(
                    controller: _descp,
                    maxLines: 3,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, ),
                      ),
                    ),

                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20,),
                  Text("Type",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Row(
                    children: [

                      Radio(
                        activeColor: Colors.red,
                        value: "expense",
                        groupValue: _typ,
                        onChanged: (val){
                          setState(() {
                            _typ = val;
                          });
                        },
                      ),
                      Text("Expense:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                      SizedBox(width: 80,),

                      Radio(

                        activeColor: Colors.green,
                        value: "income",
                        groupValue: _typ,
                        onChanged: (val){
                          setState(() {
                            _typ = val;
                          });
                        },
                      ),
                      Text("Income:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 20,),

                      Text("Amount:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10,),
                      TextField(
                        controller: _ammount,
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


                 SizedBox(height: 30,),
                       Text("Transaction Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                       Stack(
                           alignment: const Alignment(1.0, 1.0),
                           children: <Widget>[
                             new TextField(
                               controller: _date,
                               decoration: InputDecoration(
                                 focusedBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.black, width: 2.0),
                                 ),
                                 enabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: Colors.black, ),
                                 ),
                               ),
                             ),
                             new IconButton(
                                 onPressed: ()async {
                                   var datePicked = await DatePicker.showSimpleDatePicker(
                                     context,
                                     initialDate: DateTime(2022),
                                     firstDate: DateTime(1960),
                                     lastDate: DateTime(2025),
                                     dateFormat: "dd-MMMM-yyyy",
                                     looping: true,
                                   );
                                   setState(() {
                                     String formattedDate = DateFormat('dd-MM-yyyy').format(datePicked);
                                     time=formattedDate.toString();
                                     _date.text = time;
                                   });
                                 },
                               icon: Icon(Icons.calendar_today_outlined)),
                           ]
                       ),
                       SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () async{

                      var head =_head.text.toString();
                      var descp = _descp.text.toString();
                      var typ = _typ.toString();
                      var ammount = _ammount.text.toString();
                      var dat = _date.text.toString();

                      if(head.length<=0)
                        {
                          Fluttertoast.showToast(
                              msg: "Please Add Your Title",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      else if(descp.length<=0)
                        {
                          Fluttertoast.showToast(
                              msg: "Please create description",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.indigo,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      else if(ammount.length<=0)
                        {
                          Fluttertoast.showToast(
                              msg: "Please Add Your Ammount",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.green,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }
                      else if (dat.length<=0)
                        {
                          Fluttertoast.showToast(
                              msg: "Please Add Your Date",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red.shade200,
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                        }

                      else
                        {
                          DatabaseHandler obj = new DatabaseHandler();
                          var id = await obj.addexpense(head,descp,typ,ammount,dat);
                          _head.text="";
                          _descp.text="";
                          _ammount.text="";
                          _date.text="";
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ExpenseMangerHomePage())
                          );
                        }



                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue,
                      child: Text("Add",style: TextStyle(fontSize: 20,color: Colors.white),),
                    ),
                  )
                     ],
                   ),

            ),
          ],
        ),
      ),
    );
  }
}
