import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trimly/pages/Forgetpassword.dart';
import 'package:trimly/pages/Home.dart';
import 'package:trimly/pages/Signup.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
   final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

   bool userfound=false;
  @override
  Widget build(BuildContext context) {
    Size mediaQuery=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 60,left: 30),
              width: mediaQuery.width,
              height: mediaQuery.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFB91635),
                  Color(0xFF621d3c),
                  Color(0xFF311937),
                ])),
              child: Text("Hello\nSign in!",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: mediaQuery.height*.06),
                padding: EdgeInsets.only(top: 40,left: 30,right: 30),
                width: mediaQuery.width,
                height: mediaQuery.height/1.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40) )
                ),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined)
                        ),
                      validator: (value){
                          if(value==null||value.isEmpty){
                            return "Please enter email";
                          }
                          return null;
                      }),
                      SizedBox(height: 40,),
                      Text("Password",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password_outlined)
                        ),
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Please enter password";
                            }
                            return null;
                          }),
                      SizedBox(height: 20,),

                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgetpassword()));
                          },
                              child: Text("Forgot Password?",style: TextStyle(color: Color(0xFF311937),fontSize: 20),)),
                        ],
                      ),
                      SizedBox(height: 7,),
                      GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          _formKey.currentState!.validate();
                          LogingInUser();
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
                          child: Center(child: Text("Sign In",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),),
                      ),

                      Spacer(),
                      Divider(thickness: 2,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupUser()));
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",style: TextStyle(color: Color(0xFF311937),fontSize: 15),),
                            Text("Sign up",style: TextStyle(color: Color(0xFF621d3c),fontSize: 15,fontWeight: FontWeight.bold),),
                          ]),
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
  LogingInUser() {
    if (emailController != '' && passwordController.text != ''){
      showDialog(context: context,
          builder: (context)=>Center(child: CircularProgressIndicator()));
      FirebaseFirestore.instance.collection("Users").get().then((snapshot) {
        snapshot.docs.forEach((user) async {
          if (user.data()["Email"] == emailController.text) {
            userfound=true;
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
            }
            on FirebaseAuthException catch (ex) {
              Navigator.pop(context);
              print(ex.code.toString());
              if (ex.code == 'wrong-password'|| ex.code=='invalid-credential') {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Center(
                        child: Text("Incorrect password", style: TextStyle(
                            color: Colors.white),)),
                      backgroundColor: Colors.red,));
              }}
          }
        });
        if(!userfound){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(
                  child: Text("User not found", style: TextStyle(
                      color: Colors.white),)),
                backgroundColor: Colors.red,));
        }
        userfound =false;
      });
    }}
}
