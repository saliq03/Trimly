import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 70),
              Text("Password Recovery",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("Enter your email",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              TextFormField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail_outline,color: Colors.white,),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2
                    )
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 2
                      )),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 2
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2
                      )
                  )
                ),
              validator: (value){
                  if(value==null||value.isEmpty){
                    return "Please enter email";
                  }
                  return null;
              },),
              SizedBox(height: 40),
              GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
               _formKey.currentState!.validate();
               ResetPassword();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(22),
                    color: Colors.brown
                  ),
                  child: Center(child: Text("Send Email",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  ResetPassword()async{
    if(emailController.text!=''){
      showDialog(context: context,
          builder: (context)=>Center(child: CircularProgressIndicator()));
      try{
       await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
       ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Center(
               child: Text("Password reset email has been sent to the given email", style: TextStyle(
                   color: Colors.white),)),
             backgroundColor: Colors.black26,));
       Navigator.pop(context);
      } on FirebaseAuthException catch(ex){
        print(ex.toString());
        if(ex.code=='user-not-found'){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(
                  child: Text("No user found for this email", style: TextStyle(
                      color: Colors.white),))));
        }
        else if (ex.code == 'invalid-email'){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(
                  child: Text("The email address is badly formatted", style: TextStyle(
                      color: Colors.white),))));
        }
      }
    }
  }
}
