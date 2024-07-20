import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trimly/pages/EmailVerification.dart';
import 'package:trimly/pages/Login.dart';

class SignupUser extends StatefulWidget {
  const SignupUser({super.key});

  @override
  State<SignupUser> createState() => _SignupUserState();
}

class _SignupUserState extends State<SignupUser> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  bool hidepassword=true;
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
              child: Text("Create your\nAccount",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 5),
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

                      Text("Name",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: "Username",
                              prefixIcon: Icon(CupertinoIcons.person)
                          ),
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Please enter username";
                            }
                            return null;
                          }),
                      SizedBox(height: 20,),
                      Text("Email",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined)
                          ),
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Please enter Email";
                            }
                            else if(!emailRegex.hasMatch(emailController.text.trim())) {
                              return "Enter valid Email";
                            }
                            return null;
                          }),
                      SizedBox(height: 20,),
                      Text("Password",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      TextFormField(
                          controller: passwordController,
                          obscureText: hidepassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password_outlined),
                            suffixIcon: ShowingPassword()
                          ),
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return "Please enter password";
                            }
                            return null;
                          }),
                      SizedBox(height: 25,),
                      GestureDetector(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          if(_formKey.currentState!.validate()){
                            SigningUpUser();
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
                          child: Center(child: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),)),),
                      ),
                      Spacer(),
                      Divider(thickness: 2,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginUser()));
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",style: TextStyle(color: Color(0xFF311937),fontSize: 15),),
                              Text("Sign in",style: TextStyle(color: Color(0xFF621d3c),fontSize: 15,fontWeight: FontWeight.bold),),
                            ]),
                      ),
                      SizedBox(height: 20,)


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

  SigningUpUser() async {
    if(passwordController.text!=''&& emailController.text!=''&& nameController.text!='') {
      showDialog(context: context,
          builder: (context)=>Center(child: CircularProgressIndicator()));
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
        Navigator.of(context).popUntil((route)=>route.isFirst);
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Emailverification(email:  emailController.text, name: nameController.text)));
        await userCredential.user?.sendEmailVerification();
      }

      on FirebaseAuthException catch (ex) {
        Navigator.pop(context);
        if (ex.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Center(child: Text("Weak password",style: TextStyle(color: Colors.white),)),backgroundColor: Colors.red,)
          );
        }
        if(ex.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Center(child: Text("Account already exist",style: TextStyle(color: Colors.white),)),backgroundColor: Colors.orangeAccent,)
          );
        }
      }
    }
  }

  ShowingPassword(){
    return IconButton(onPressed: (){
      hidepassword=!hidepassword;
      setState(() {});
    },
        icon: hidepassword?Icon(CupertinoIcons.eye_slash_fill) :Icon(CupertinoIcons.eye_fill));
  }

}
