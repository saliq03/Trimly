import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 228, 210),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30,),
          Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello,",style: TextStyle(fontSize: 30,),),
                    Text("Saliq Javid",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                  ]),

                Image.asset("assets/images/bg.png",height: 70,width: 70,fit: BoxFit.cover,)
              ])),
          Divider(color: Colors.black,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Column(
              children: [
                Text("Services",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)

              ]

            ),
          )
        ],
      ),
    );
  }
}
