import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:trimly/Database/Databasemethods.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Database/SharedPrefrenceHelper.dart';
import 'Booking.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String? name;
   String? image;
   File? pickedImage;
   String? email;

@override
  void initState() {
   GetSharedprefData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 228, 210),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello,",style: TextStyle(fontSize: 25,),),
                    Text(name!,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                  ]),

                GestureDetector(onTap: (){
                  ShowImageUploadDialog();
                },
                    child: ClipRRect(borderRadius: BorderRadius.circular(35),
                        child: pickedImage!=null? Image.file(pickedImage!,height: 70,width: 70,fit: BoxFit.cover,): Image.network(image!,height: 70,width: 70,fit: BoxFit.cover,)))
              ])),

          Row(mainAxisAlignment:MainAxisAlignment.end, children: [GestureDetector(onTap: (){
            Navigator.pop(context);
            SharedprefrenceHelper().SetLoginkey(false);
          },
            child: Text("Log out   ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),)],),
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
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Booking(Service: title)));
        },
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
      ),
    );
  }
  GetSharedprefData()async{
    name=await SharedprefrenceHelper().GetUserName();
    image=await SharedprefrenceHelper().GetUserImage();
    email =await SharedprefrenceHelper().GetUserEmail();
    setState(() {});
  }

  PickImage()async{
  try{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image==null)return;
    final tempimage=File(image.path);
    CompressImage(tempimage);
  }
    catch (ex){

    print(ex.toString());
    }
  }
   CompressImage(File file) async {
     var compressedImage= await FlutterImageCompress.compressAndGetFile(
         file.absolute.path,
         "${file.absolute.parent.path}/temp.jpg",
     quality: 80,
     minHeight: 500,
     minWidth: 500);
     pickedImage=File(compressedImage!.path);
     setState(() {});

   }

  ShowImageUploadDialog(){
    return showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Container(
          child: Column(
            children: [
              Text("Upload Profile Photo"),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  PickImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(color: Colors.black),
                  ),
                  child: pickedImage!=null? ClipRRect(  borderRadius: BorderRadius.circular(11),
                      child: Image.file(pickedImage!,height: 100,width: 100,fit: BoxFit.cover,)):Center(child: Icon(Icons.camera_alt_outlined)),),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()async{
                  if(pickedImage!=null){
                    showDialog(context: context,
                        builder: (context)=>Center(child: CircularProgressIndicator()));

                    String id = randomAlphaNumeric(10);
                   FirebaseStorage storage=FirebaseStorage.instanceFor(bucket: "trimly-61b9f.appspot.com");
                   TaskSnapshot snapshot=await storage.ref("ProfileImage").child(id).putFile(pickedImage!);
                   String imageUrl= await snapshot.ref.getDownloadURL();
                    Databasemethods().UpdateUserProfileImage(email!, imageUrl).then((value){
                      SharedprefrenceHelper().SetUserImage(imageUrl);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Center(child: Text("Image Uploaded Sucessfully")),
                          backgroundColor: Colors.green,));

                    });
                  }


                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(22)),
                  child: Center(child: Text("Upload",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),)),),
              ),
            ],
          ),
        ),
      );
    });
  }

  }

