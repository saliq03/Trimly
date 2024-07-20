import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trimly/Admin/Admin_Login.dart';
import 'package:trimly/Database/Databasemethods.dart';

import '../Database/SharedPrefrenceHelper.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({super.key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Bookings",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
          SharedprefrenceHelper().SetAdminLoginkey(false);
        }, icon: Icon(Icons.logout,color: Colors.black,))],
        backgroundColor: Colors.white,
      ),
      body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Bookings").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context,index){
                      var ds=snapshot.data!.docs[index];
                      return Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(colors: [Color(0xFF6C3F31),Color(0xFF86563C),Color(0xFF4E312D),],begin: Alignment.topLeft,end: Alignment.bottomRight)),
                        child: Column(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(35),
                                child: Image.network(ds["Image"],fit: BoxFit.cover,height: 70,width: 70,)),
                            SizedBox(height: 10),
                            Text("Service: ${ds["Service"]}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            Text("Name: ${ds["Name"]}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            // Text("Email: ${ds["Email"]}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            Text("Date: ${ds["Date"]}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            Text("Time: ${ds["Time"]}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: (){
                                Databasemethods().DeleteBooking(ds.id);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(22)),
                                child: Center(child: Text("Done",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),)),),
                            ),
                          ],
                        ),
                      );
                    });
              }
              else if(snapshot.hasError){
                return Center(child: Text("Error occured"));
              }
              else{
                return Center(child: Text("No data found"));
              }

            }
            else{
              return Center(child: CircularProgressIndicator());
            }

          }),
    );
  }
}
