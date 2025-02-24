import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trimly/Admin/AllBookings.dart';
import 'package:trimly/Database/SharedPrefrenceHelper.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool userfound=false;
  bool hidepassword=true;
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 60, left: 30),
              width: mediaQuery.width,
              height: mediaQuery.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFFB91635),
                    Color(0xFF621d3c),
                    Color(0xFF311937),
                  ])),
              child: Text("Let's start with\nAdmin", style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: mediaQuery.height * .06),
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                width: mediaQuery.width,
                height: mediaQuery.height / 1.35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))
                ),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username", style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25, color: Color(
                          0xFFB91635),),),
                      SizedBox(height: 10,),
                      TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Username",
                              prefixIcon: Icon(Icons.email_outlined)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Username";
                            }
                            return null;
                          }),
                      SizedBox(height: 40,),
                      Text("Password", style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 25, color: Color(
                          0xFFB91635),),),
                      SizedBox(height: 10,),
                      TextFormField(
                          controller: passwordController,
                          obscureText: hidepassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password_outlined),
                            suffixIcon: ShowingPassword()
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            }
                            return null;
                          }),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            LoggingInAdmin();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          width: mediaQuery.width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFFB91635),
                                Color(0xFF621d3c),
                                Color(0xFF311937),
                              ]),
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(child: Text("LogIn", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),)),),
                      ),


                      SizedBox(height: 30,)


                    ],
                  ),
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
    LoggingInAdmin()async{
    showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));
      await FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
       snapshot.docs.forEach((user){
         if(emailController.text==user.data()["Username"]){
           userfound=true;
           if(passwordController.text==user.data()["Password"]){
             Navigator.of(context).popUntil((route)=>route.isFirst);
             Navigator.push(context, MaterialPageRoute(
                 builder: (context) => AllBookings()));
             SharedprefrenceHelper().SetAdminLoginkey(true);
           }
           else{
             Navigator.pop(context);
             ScaffoldMessenger.of(context).
             showSnackBar(SnackBar(content: Center(child: Text("Incorrect password")),backgroundColor: Colors.redAccent,));
           }
         }
       });
      });
      if(!userfound){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).
        showSnackBar(SnackBar(content: Center(child: Text("User not found")),backgroundColor: Colors.orange,));
      }
      userfound=false;
    }

    ShowingPassword(){
    return IconButton(onPressed: (){
      hidepassword=!hidepassword;
      setState(() {});
    },
        icon: hidepassword?Icon(CupertinoIcons.eye_slash_fill) :Icon(CupertinoIcons.eye_fill));
    }

  }

