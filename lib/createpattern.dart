

import 'package:flutter/material.dart';

class createpattern extends StatefulWidget {
  const createpattern({Key? key}) : super(key: key);

  @override
  State<createpattern> createState() => _createpatternState();
}

class _createpatternState extends State<createpattern> {
  var finalpattern="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var pattern="";
    for(var i=1;i<=5;i++)
    {
      for(var j=1;j<=i;j++)
      {
        pattern=pattern+" * ";
      }
      pattern=pattern+"\n";
    }
    setState(() {
      finalpattern=pattern;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("createpattern"),
      ),


        body: Center(
          child: Text(finalpattern,maxLines: 20, style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black) ,),
        ),
      );
    }
  }


