import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthnew/pages/homepage.dart';
import 'package:firebaseauthnew/pages/loginpage.dart';
import 'package:firebaseauthnew/widgets/buttondesign.dart';
import 'package:firebaseauthnew/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  FirebaseFirestore store = FirebaseFirestore.instance;

  FirebaseAuth auth = FirebaseAuth.instance;

  signUp(
      {required String userName,
      required String userEmail,
      required userPassword}) async {
    try {
      print("worked");
      UserCredential userData = await auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);

      print(userData.user!.email);

      if (userData.user != null) {
        //SharedPreferences store = await SharedPreferences.getInstance();
        // await store.setString("email", userData.user!.email!);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return HomePage();
        // }));

        toastMessage(message: "Successfully registered", bgClr: Colors.green);

        await store.collection("users").add({
          "name": nameCtrl.text,
          "email": emailCtrl.text,
        });
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == "email-already-in-use") {
        return toastMessage(message: "Email already registered");
      }
      if (error.code == "invalid-email") {
        return toastMessage(message: "Please check your email address");
      }

      if (error.code == "weak-password") {
        return toastMessage(
            message: "Password should be at least 6 characters");
      }
    }
  }

  toastMessage({required String message, Color bgClr = Colors.red}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgClr,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                const Image(height: 100, image: AssetImage("assets/login.png")),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("Welcome",
                        style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 30))),
                  ),
                ),

                TextFieldDesign(
                  hintText: "Enter your name",
                  controller: nameCtrl,
                ),

                const SizedBox(height: 15),

                TextFieldDesign(
                  hintText: "Enter your email",
                  controller: emailCtrl,
                ),

                const SizedBox(height: 15),
                //password

                TextFieldDesign(
                  hintText: "Enter your password",
                  controller: passCtrl,
                  suffixIcon: const Icon(
                    Icons.visibility,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 30,
                ),

                ButtonDesign(
                    buttonText: "Create Account",
                    onTap: () {
                      if (nameCtrl.text.isNotEmpty &&
                          emailCtrl.text.isNotEmpty &&
                          passCtrl.text.isNotEmpty) {
                        signUp(
                            userName: nameCtrl.text,
                            userEmail: emailCtrl.text,
                            userPassword: passCtrl.text);
                      } else {
                        toastMessage(message: "please fill all fields");
                      }
                    }),

                const SizedBox(height: 50),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",
                        style: GoogleFonts.oswald(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.oswald(
                          textStyle: const TextStyle(
                            color: Color(0xFF35C2C1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
