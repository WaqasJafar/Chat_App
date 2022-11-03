// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({Key? key, this.onPressed}) : super(key: key);
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.right_chevron,
              color: CupertinoColors.white.withOpacity(0.7)),
          // ignore: unnecessary_string_escapes
          Text("Let\'s Start",
              style: TextStyle(
                color: CupertinoColors.white.withOpacity(0.7),
                fontSize: 25,
              ))
        ],
      ),
    );
  }
}
