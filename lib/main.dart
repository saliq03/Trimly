import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/Onboarding.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyB-QmMT1zMUBxWOVNDQXgSJA6egBxZZ3rk",
      appId: "1:648454734421:android:f07f9bfc9731a5b6e30adc",
      messagingSenderId: "648454734421",
      projectId: "trimly-61b9f")):
      Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trimly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:Onboarding()
    );
  }
}


