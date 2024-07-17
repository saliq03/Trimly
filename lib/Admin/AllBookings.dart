import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color:Color(0xFF3E2723)),
                        child: Column(
                          children: [
                            CircleAvatar(child:Image.network("https://firebasestorage.googleapis.com/v0/b/trimly-61b9f.appspot.com/o/Hair%20Cutting.png?alt=media&token=2ff33638-7c90-4cf7-b172-9693c5533083"),backgroundColor: Colors.white,radius: 50,),
                            Text(ds["Name"],style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                            Text(ds["Email"],style: TextStyle(color: Colors.white,fontSize: 20),),
                            Text(ds["Service"],style: TextStyle(color: Colors.white,fontSize: 20),),
                            Text(ds["Date"],style: TextStyle(color: Colors.white,fontSize: 20),),
                            Text(ds["Time"],style: TextStyle(color: Colors.white,fontSize: 20),)
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
