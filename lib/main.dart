import 'package:chat/screens/HomeScreen.dart';
import 'package:chat/screens/LoginScreen.dart';
import 'package:chat/screens/next.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => const MyPhone(),
      'verify': (context) => const MyVerify(),
      'next': (context) => const next()
    },
  ));
}
