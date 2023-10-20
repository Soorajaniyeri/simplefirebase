import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthnew/pages/homepage.dart';
import 'package:firebaseauthnew/pages/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/buttondesign.dart';
import '../widgets/textfieldwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

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

  login({required String email, required password}) async {
    try {
      UserCredential userValue = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return HomePage();
      }));
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == "INVALID_LOGIN_CREDENTIALS") {
        return toastMessage(message: "Invalid details ");
      }

      if (error.code == "invalid-email") {
        return toastMessage(message: "please check your email");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                const SizedBox(height: 15),

                // Text fields for login

                TextFieldDesign(
                  hintText: "Enter your email",
                  controller: emailCtrl,
                ),

                const SizedBox(height: 15),

                TextFieldDesign(
                  inputType: TextInputType.number,
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //         const ForgotPasswordScreen()));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color(0xFF6A707C),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                ButtonDesign(
                    buttonText: "Login",
                    onTap: () {
                      if (emailCtrl.text.isNotEmpty &&
                          passCtrl.text.isNotEmpty) {
                        login(email: emailCtrl.text, password: passCtrl.text);
                      } else {
                        toastMessage(message: "please fill all fields");
                      }
                    }),

                const SizedBox(height: 50),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account? ",
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
                          return SignupPage();
                        }));
                      },
                      child: Text(
                        "Register",
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
