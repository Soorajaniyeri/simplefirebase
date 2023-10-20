import 'package:firebase_core/firebase_core.dart';

import 'package:firebaseauthnew/pages/firebaseSignup.dart';
import 'package:firebaseauthnew/pages/loginpage.dart';
import 'package:firebaseauthnew/pages/signuppage.dart';
import 'package:firebaseauthnew/pages/splashscreen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:FirebaseSignUp()
    );
  }
}

