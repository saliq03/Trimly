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

  AddBooking(String email,String name,String service,String date,String time)async{
    await FirebaseFirestore.instance.
    collection("Bookings").
    add({
      "Email":email,
      "Name": name,
      "Service": service,
      "Date": date,
      "Time": time
    });
  }
}