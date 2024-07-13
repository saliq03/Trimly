import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Emailverification extends StatefulWidget {
  const Emailverification({super.key});

  @override
  State<Emailverification> createState() => _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: Column(

          children: [
            SizedBox(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,),
            Icon(CupertinoIcons.mail,color: Colors.white,size: 80,),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Text("An email has been sent to:",style: TextStyle(color: Colors.white60,fontSize:20)),
            Text("javidsaliq@gmail.com",style: TextStyle(color: Colors.white,fontSize:22,fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            Text("Please follow the instructions in the ",style: TextStyle(color: Colors.white60,fontSize:20)),
            Text("verification email to finish signing up.",style: TextStyle(color: Colors.white60,fontSize:20)),
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width/2,
              color: Colors.white12,
              child: Center(child: Text("Done",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)),
            ),
            SizedBox(height: 30,),
            Text("Resend",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),)

          ],
        ),
      ),
    );
  }
}
