import 'dart:async';

import 'package:docker/dashboard.dart';
import 'package:docker/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null) ? false : prefs.getBool('isLoggedIn');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: isLoggedIn! ? Dashboard() : LoginScreen(),
  ));

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(HomePage());
}

