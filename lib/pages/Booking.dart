
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trimly/Database/Databasemethods.dart';
import '../Database/SharedPrefrenceHelper.dart';

class Booking extends StatefulWidget {
 final String Service;

  const Booking({required this.Service});


  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime _selectedDate=DateTime.now();
  TimeOfDay _selectedTime=TimeOfDay.now();
   String? Email;
   String? Name;
   String? myImage;

  Future<void> SelectDate()async{
    final DateTime? picked=await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));
    if(picked!=null){
      setState(() {
        _selectedDate=picked;
      });
    }
  }

  Future<void> SelectTime()async{
    final TimeOfDay? picked=await showTimePicker(
        context: context,
        initialTime: _selectedTime);
    if(picked!=null){
      setState(() {
        _selectedTime=picked;
      });
    }
  }
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let's begin\nthe journey",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            ClipRRect(borderRadius: BorderRadius.circular(25),
                child: Image.asset("assets/images/off.jpg",width: MediaQuery.of(context).size.width,)),
            SizedBox(height: 20,),

            Text(widget.Service,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color(0xFF3E2723)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Set Date",style: TextStyle(color: Colors.white70,fontSize: 20),),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    IconButton(onPressed: (){SelectDate();}, icon: Icon(Icons.calendar_month,color: Colors.white,size: 30,)),
                    Text("${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                  ],)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 130,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Color(0xFF3E2723)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Set Time",style: TextStyle(color: Colors.white70,fontSize: 20),),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){SelectTime();}, icon: Icon(CupertinoIcons.clock_fill,color: Colors.white,size: 30,)),
                      Text(_selectedTime.format(context),style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    ],)
                ],
              ),
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: (){
                UploadBooking();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(22)),
                child: Center(child: Text("BOOK NOW",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),),
            ),

          ],
        ),
      ),
    );
  }

  UploadBooking() async {
   // var id=randomAlphaNumeric(10);
    showDialog(context: context,
        builder: (context)=>Center(child: CircularProgressIndicator()));
    Name=await SharedprefrenceHelper().GetUserName();
    Email=await SharedprefrenceHelper().GetUserEmail();
    myImage= await SharedprefrenceHelper().GetUserImage();
    await Databasemethods().AddBooking(

        Email!,
        Name!,
        widget.Service,
        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
        _selectedTime.format(context).toString(),myImage!).then((value){
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Center(
              child: Text("Service has been added Successfully.", style: TextStyle(
                  color: Colors.white),))));
    });

  }
}
