import 'package:flutter/material.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {

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
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email_outlined)
                        ),),
                      SizedBox(height: 40,),
                      Text("Password",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Color(0xFFB91635),),),
                      SizedBox(height: 10,),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password_outlined)
                        ),),
                      SizedBox(height: 20,),

                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forgot Password?",style: TextStyle(color: Color(0xFF311937),fontSize: 20),),
                        ],
                      ),
                      SizedBox(height: 7,),
                      Container(
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
                      SizedBox(height: 40,),
                      Spacer(),
                      Divider(thickness: 2,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",style: TextStyle(color: Color(0xFF311937),fontSize: 15),),
                          Text("Sign up",style: TextStyle(color: Color(0xFF621d3c),fontSize: 15,fontWeight: FontWeight.bold),),
                        ]),
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
}
