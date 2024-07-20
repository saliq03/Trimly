import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trimly/Database/Databasemethods.dart';
import 'package:trimly/pages/Home.dart';

import '../Database/SharedPrefrenceHelper.dart';


class AuthServices{

  SignInWithGoogle(BuildContext context)async{
    showDialog(context: context,
        builder: (context)=>Center(child: CircularProgressIndicator()));

    // signing in with google logic starts from here
   final GoogleSignInAccount? guser= await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth=await guser!.authentication;

    final crediential=GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken
    );

    UserCredential result= await FirebaseAuth.instance.signInWithCredential(crediential);
    // To here

    User? userDetails=result.user;

    if(result!=null){
      Databasemethods().
      AddUserDetails(userDetails!.displayName!, userDetails.email!, userDetails.photoURL!)
          .then((value){
            SharedprefrenceHelper().SetLoginkey(true);
            SharedprefrenceHelper().SetUserName(userDetails!.displayName!);
            SharedprefrenceHelper().SetUserEmail(userDetails.email!);
            SharedprefrenceHelper().SetUserImage(userDetails.photoURL!);
            Navigator.of(context).popUntil((route)=>route.isFirst);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      });
    }
    else{
      Navigator.pop(context);
    }
  }
}