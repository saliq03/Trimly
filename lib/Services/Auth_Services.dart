import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trimly/Database/Databasemethods.dart';
import 'package:trimly/pages/try.dart';

class AuthServices{

  SignInWithGoogle(BuildContext context)async{
   final GoogleSignInAccount? guser= await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth=await guser!.authentication;

    final crediential=GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken
    );

    UserCredential result= await FirebaseAuth.instance.signInWithCredential(crediential);
    User? userDetails=result.user;

    if(result!=null){
      Databasemethods().
      AddUserDetails(userDetails!.displayName!, userDetails.email!, userDetails.photoURL!)
          .then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Try()));
      });
    }
  }
}