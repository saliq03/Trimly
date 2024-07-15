import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trimly/Database/Databasemethods.dart';
import 'package:trimly/Database/SharedPrefrenceHelper.dart';
import 'package:trimly/pages/Home.dart';

class Emailverification extends StatefulWidget {
  final String email;
  final String name;
  Emailverification({required this.email,required this.name});


  @override
  State<Emailverification> createState() => _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification>{
  FirebaseAuth _auth=FirebaseAuth.instance;
  late Timer timer;



  @override
  void initState() {
    super.initState();
    timer=Timer.periodic(Duration(seconds: 3), (timer){
      _auth.currentUser?.reload();
      if(_auth.currentUser?.emailVerified==true){
        SetSharedpref();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text("Registered sucessfully"),backgroundColor: Colors.green,));
        UploadUserDetails();
      }
    });
  }

 @override
  void dispose() {
   timer.cancel();
   super.dispose();
     EmailNotVerified();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        padding: EdgeInsets.only(top: 100,bottom: 70),
        child: Column(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,),
            Icon(CupertinoIcons.mail,color: Colors.white,size: 80,),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Text("An email has been sent to:",style: TextStyle(color: Colors.white60,fontSize:20)),
            Text(widget.email,style: TextStyle(color: Colors.white,fontSize:22,fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            Text("Please follow the instructions in the ",style: TextStyle(color: Colors.white60,fontSize:20)),
            Text("verification email to finish signing up.",style: TextStyle(color: Colors.white60,fontSize:20)),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                _auth.currentUser?.sendEmailVerification();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width/2,
                color: Colors.white12,
                child: Center(child: Text("Resend",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
              ),
            ),
           Spacer(),
           GestureDetector(onTap: (){
             EmailNotVerified();
             Navigator.pop(context);
           },
               child: Center(child: Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25))))
          ],
        ),
      ),
    );
  }

  EmailNotVerified() async {
    if(_auth.currentUser?.emailVerified!=true){
      await _auth.currentUser?.delete();
    }
  }

  UploadUserDetails(){
    Databasemethods().AddUserDetails(widget.name, widget.email);
  }

  SetSharedpref(){
    SharedprefrenceHelper().SetLoginkey(true);
    SharedprefrenceHelper().SetUserName(widget.name);
    SharedprefrenceHelper().SetUserEmail(widget.email);
  }
}
