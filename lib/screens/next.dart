// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';

class next extends StatefulWidget {
  const next({Key? key}) : super(key: key);

  @override
  State<next> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<next> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Phone Verification Done",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
