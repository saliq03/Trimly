import 'package:flutter/material.dart';
import 'package:trimly/Admin/Admin_Login.dart';
import 'package:trimly/Admin/AllBookings.dart';
import 'package:trimly/pages/Home.dart';
import 'package:trimly/pages/Login.dart';

import '../Database/SharedPrefrenceHelper.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool? loginKey,adminLoginKey;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 228, 210),
      body: Column(
        children: [

          SizedBox(height: 50,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [GestureDetector(onTap: ()async{
              adminLoginKey= await SharedprefrenceHelper().GetAdminLoginkey();
              if(adminLoginKey==true){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBookings()));
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
              }
            },
                child: Text("Admin",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black,fontStyle: FontStyle.italic),)),SizedBox(width: 20)]),
          Image.asset("assets/images/bg.png"),
          SizedBox(height: 40,),
          GestureDetector(
            onTap: () async {
              loginKey=await SharedprefrenceHelper().GetLoginkey();
              if(loginKey==true){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              }
              else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginUser()));
              }
            },
            child: Material(
              elevation: 9,
                borderRadius: BorderRadius.circular(25),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(child: Text("Get Haircut",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
              ),
            ),
          )
        ],
      ),
    );
  }

}
