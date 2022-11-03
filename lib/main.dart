import 'package:chat/screens/HomeScreen.dart';
import 'package:chat/screens/LoginScreen.dart';
import 'package:chat/screens/login/hello.dart';
// import 'package:chat/screens/next.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return (MaterialApp(
      initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      routes: {
        'hello': (context) => const Hello(),
        'phone': (context) => const MyPhone(),
        'verify': (context) => const MyVerify(),
        // 'next': (context) => const next()
      },
    ));
  }
}
