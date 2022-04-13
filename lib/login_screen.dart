import 'package:docker/dashboard.dart';
import 'package:docker/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fire_auth.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);



  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }


  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _passwordVisible = false;
  BuildContext? dialogContext;
  bool  isForgetPassword= false;

  @override
  void initState() {
    _passwordVisible = false;
  }

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
          body:
          FutureBuilder(
              future: _initializeFirebase(),
              builder: (context, snapshot)
              {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    "assets/images/docker-2.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "DOCKER AID",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Changa",
                                  fontSize: 40),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: _emailTextController,
                              style: TextStyle(
                                  fontFamily: "Changa", color: Colors.black),
                              decoration: InputDecoration(
                                hintStyle:
                                TextStyle(
                                    fontFamily: "Changa", color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                hintText: 'Email ID',
                              ),
                            ),
                          ),
                          !isForgetPassword ?
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: TextField(
                              controller: _passwordTextController,
                              style: TextStyle(
                                  fontFamily: "Changa", color: Colors.black),
                              obscureText: !_passwordVisible,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintStyle:
                                TextStyle(
                                    fontFamily: "Changa", color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.blue.shade100,
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme
                                        .of(context)
                                        .primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ):SizedBox(),
                          if(!isForgetPassword)...[
                          // !isForgetPassword ?
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(_isValid()) {
                                    showLoading();
                                    User? user = await FireAuth
                                        .signInUsingEmailPassword(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text,
                                      context: context,
                                    );
                                    hideLoading();
                                    if (user != null) {
                                      snackBar(message: 'Successful LogIn',
                                          status: "success");
                                      SharedPreferences prefs = await SharedPreferences
                                          .getInstance();
                                      prefs.setBool('isLoggedIn', true);
                                      print(prefs.getBool("isLoggedIn")
                                          .toString());
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard()),
                                      );
                                    } else {
                                      snackBar(
                                          message: 'Incorrect ID/Password ',
                                          status: "error");
                                    }
                                  }else snackBar(
                                      message: 'Enter ID/Password ',
                                      status: "warning");

                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontFamily: "Changa", fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // <-- Radius
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
                          )]else
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ElevatedButton(
                                onPressed: () async {

                                  if (_emailTextController.text.isNotEmpty) {
                                    showLoading();
                                    final list = await FirebaseAuth.instance
                                        .fetchSignInMethodsForEmail(
                                        _emailTextController.text);

                                    print(list.toString());

                                    // In case list is not empty
                                    if (list.isNotEmpty) {
                                      // Return true because there is an existing
                                      // user using the email address
                                      FireAuth.resetPassword(
                                          _emailTextController.text);
                                      hideLoading();
                                      snackBar(
                                          message: 'Check Email to reset password',
                                          status: 'success');
                                    } else {
                                      hideLoading();
                                      snackBar(
                                          message: 'Email ID does not exists',
                                          status: 'error');
                                      // Return false because email adress is not in use
                                    }
                                  }else snackBar(message: 'Enter Email address',status: 'warning');
                                },
                                child: Text(
                                  'Verify',
                                  style: TextStyle(
                                      fontFamily: "Changa", fontSize: 25),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // <-- Radius
                                  ),
                                ),
                              ),
                            ),
                          ),

                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isForgetPassword ? Padding(
                                  padding: EdgeInsets.all(15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isForgetPassword = false;

                                      });
                                      print("Sign In");
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          fontFamily: "Changa",
                                          color: Colors.white),
                                    ),
                                  ),
                                ) :
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                      isForgetPassword = true;

                                      });
                                      print("Forget Password");
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                          fontFamily: "Changa",
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: VerticalDivider(
                                    color: Colors.white,
                                    thickness: 1,
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
                                          const SignupScreen(),
                                        ),
                                      );
                                      print("Register Yourself");
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                          fontFamily: "Changa",
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          )


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

  snackBar({required String message, String? status}) {
    Color color;
    if (status == "success") {
      color =  Color(0xFF007E33);
    } else if (status == "error") {
      color =  Color(0xFFB00020);
    } else if (status == "warning") {
      color =  Color(0xFFFF8800);
    } else {
      color = Color(0xFF121212);
    }
    final snackBar = SnackBar(content: Text(message, style: TextStyle(fontFamily: 'Changa'), textAlign: TextAlign.center), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _isValid(){
    if (_emailTextController.text.isNotEmpty && _passwordTextController.text.isNotEmpty){
      return true;
    }else return false;
  }
}
