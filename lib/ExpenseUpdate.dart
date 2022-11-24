import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/ExpenseMangerHomePage.dart';
import 'package:untitled1/helper/DatabaseHandler.dart';

class ExpenseUpdate extends StatefulWidget {
  var updateid;
  ExpenseUpdate({this.updateid});


  @override
  State<ExpenseUpdate> createState() => _ExpenseUpdateState();
}

class _ExpenseUpdateState extends State<ExpenseUpdate> {

  TextEditingController _head = TextEditingController();
  TextEditingController _descp = TextEditingController();
  TextEditingController _ammount = TextEditingController();




  String time = '?';

  var _typ="income";
  TextEditingController _date = TextEditingController();

  getupdatedata()async
  {
    DatabaseHandler obj = new DatabaseHandler();
   var updatedata = await obj.getsingleExpense(widget.updateid);
   setState(() {
     _head.text = updatedata[0]["expense_head"].toString();
     _descp.text = updatedata[0]["descp"].toString();
     _typ = updatedata[0]["typ"].toString();
     _ammount.text = updatedata[0]["amount"].toString();
     _date.text = updatedata[0]["dat"].toString();
   });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getupdatedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: Center(
          child: Text("Update"),
        ),
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
                  TextField(
                    controller: _descp,
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

                  Text("AMMOUNT:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
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
                  Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                        new ElevatedButton(
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
                            child: new Icon(Icons.calendar_today_outlined))
                      ]
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child:  ElevatedButton(
                      onPressed: (){
                        var head =_head.text.toString();
                        var descp = _descp.text.toString();
                        var typ = _typ.toString();
                        var ammount = _ammount.text.toString();
                        var dat = _date.text.toString();

                        DatabaseHandler obj = new DatabaseHandler();

                        obj.saveexpense(head,descp,typ,ammount,dat,widget.updateid);

                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>ExpenseMangerHomePage())
                        );

                      },




                      child: Text("Update",style: TextStyle(fontSize: 20,color:Colors.white),),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }
}
