import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauthnew/pages/loginpage.dart';
import 'package:firebaseauthnew/pages/splashscreen.dart';
import 'package:firebaseauthnew/widgets/buttondesign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userEmail;
  FirebaseAuth auth = FirebaseAuth.instance;

  loadData() async {
    String? userData = auth.currentUser!.email;
    if (userData != null) {
      setState(() {
        userEmail = userData;
      });
    } else {}
  }

  logout() async {
    await auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return SplashScreen();
    }));
  }

  @override
  void initState() {
    loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text("HomePage"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: userEmail == null
                  ? SizedBox()
                  : Text(
                      userEmail!,
                      style: GoogleFonts.cabin(
                          textStyle:
                              TextStyle(fontSize: 25, color: Colors.blue)),
                    ),

              // child: Text(auth.currentUser!.email!)),
            ),
            SizedBox(
              height: 40,
            ),
            ButtonDesign(
                buttonText: "Logout",
                onTap: () {
                  logout();
                })
          ],
        ));
  }
}
