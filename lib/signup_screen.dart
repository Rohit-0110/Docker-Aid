import 'package:docker/dashboard.dart';
import 'package:docker/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'fire_auth.dart';

class SignupScreen extends StatefulWidget {

  static String id = 'SignUp';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                // Colors.brown.shade300.withOpacity(.8),
                const Color(0xFFACC8E5),
                const Color(0xFF112A46),
                // Colors.brown.shade100.withOpacity(.6),
              ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Registration",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Changa",
                        fontSize: 40),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _nameTextController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontFamily: "Changa", color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontFamily: "Changa", color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      hintText: 'Enter Your Email ID',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _passwordTextController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontFamily: "Changa", color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      hintText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: _confirmPasswordTextController,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontFamily: "Changa", color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      hintText: 'Confirm Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_confirmPasswordTextController.text ==
                            _passwordTextController.text) {
                          User? user =
                              await FireAuth.registerUsingEmailPassword(
                            name: _nameTextController.text,
                            email: _emailTextController.text,
                            password: _passwordTextController.text,
                          );
                          if (user != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              ModalRoute.withName('/'),
                            );
                          }
                        } else
                          (print("Password Does Not Match!"));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontFamily: "Changa", fontSize: 25),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // <-- Radius
                        ),
                      ),
                      onPressed: () async {
                        showLoading();
                        User? user =
                            await FireAuth.signInWithGoogle(context: context);
                        hideLoading();
                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/google.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle)),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "SignIn with Google",
                            style: TextStyle(
                                fontFamily: "Changa",
                                fontSize: 20,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const LoginScreen()));
                      print("Already Registerd? LogIn");
                    },
                    child: Text(
                      "Already Registerd? LogIn",
                      style:
                          TextStyle(fontFamily: "Changa", color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Show loading with optional message params
  showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return SpinKitFoldingCube(
          color: Colors.blue.shade200,
          size: 40.0,
        );
        //return Loading();
      },
    );
  }

  hideLoading() {
    if (dialogContext != null) {
      Navigator.of(dialogContext!, rootNavigator: true).pop();
    }
  }
}
