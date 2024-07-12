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
                    Text("Hello,",style: TextStyle(fontSize: 25,),),
                    Text("Saliq Javid",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                  ]),

                Image.asset("assets/images/bg.png",height: 70,width: 70,fit: BoxFit.cover,)
              ])),
          Divider(color: Colors.black,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Services",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    MyServices("assets/icons/shaving.png", "Classic Shaving"),
                    SizedBox(width: 10,),
                    MyServices("assets/icons/HairWashing.png", "Hair Washing")

                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    MyServices("assets/icons/HairCutting.png", "Hair Cutting"),
                    SizedBox(width: 10,),
                    MyServices("assets/icons/trimming.png", "Beard Trimming")
                  ],),
                SizedBox(height: 10,),
                Row(
                  children: [
                    MyServices("assets/icons/facial.png", "Facials"),
                    SizedBox(width: 10,),
                    MyServices("assets/icons/kids.png", "Kids Hair Cutting")

                  ],
                )
              ]

            ),
          )
        ],
      ),
    );
  }

  MyServices(String image,String title){
    return Flexible(
      fit:FlexFit.tight,
      child: Container(
        height: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Color(0xFF3E2723)
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image,width: 80,height: 80,),
            SizedBox(height: 20,),
            Text(title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
