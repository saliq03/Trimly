import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods{
  AddUserDetails(String name,String email)async{
    await FirebaseFirestore.instance.
    collection("Users").
    doc(email).
    set({
      "Name":name,
      "Email":email,
      "Image":"abc"
    });
  }
}