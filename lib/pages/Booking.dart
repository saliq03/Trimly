import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
 final String Service;

  const Booking({required this.Service});


  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 228, 210),
      appBar: AppBar(
        leading:IconButton(onPressed: () { Navigator.pop(context); },icon:  Icon(CupertinoIcons.back,size: 30,),),
        backgroundColor: Color.fromARGB(255, 245, 228, 210),
    ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          children: [
            Text(" Let's begin\n   the journey",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
