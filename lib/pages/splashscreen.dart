import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthnew/pages/homepage.dart';
import 'package:firebaseauthnew/pages/loginpage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth status = FirebaseAuth.instance;

  checkStatus() {
    if (status.currentUser != null) {


      Timer(const Duration(seconds: 3), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const HomePage();
        }));
      });
    } else {


      Timer(const Duration(seconds: 3), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      });
    }
  }

  @override
  void initState() {
    checkStatus();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Image(height: 100, image: AssetImage("assets/login.png")),
            Expanded(child: SizedBox()),
            CircularProgressIndicator(
              color: Colors.grey.shade300,
            ),


            SizedBox(
              height: 30,
            ),



          ],
        ),
      ),
    );
  }
}
