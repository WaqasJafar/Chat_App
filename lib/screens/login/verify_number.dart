// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state

import 'package:chat/screens/login/user_name.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// ignore: constant_identifier_names
enum Status { Waiting, Error }

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, this.number}) : super(key: key);
  final number;
  @override
  // ignore: library_private_types_in_public_api
  _VerifyNumberState createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId;
  final _textEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _VerifyNumberState(this.phoneNumber);

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phonesAuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (_verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value) {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const UserName()));
          })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              _textEditingController.text = "";
              _status = Status.Error;
            });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Verify Number"),
        previousPageTitle: "Edit Number",
      ),
      child: _status != Status.Error
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text("OTP Verification",
                      style: TextStyle(
                          color: const Color(0xFF08C187).withOpacity(0.7),
                          fontSize: 30)),
                ),
                const Text("Enter OTP sent to",
                    style: TextStyle(
                        color: CupertinoColors.secondaryLabel, fontSize: 20)),
                Text(phoneNumber ?? ""),
                CupertinoTextField(
                    onChanged: (value) async {
                      // ignore: avoid_print
                      print(value);
                      if (value.length == 6) {
                        //perform the auth verification
                        _sendCodeToFirebase(code: value);
                      }
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(letterSpacing: 30, fontSize: 30),
                    maxLength: 6,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive the OTP?"),
                    CupertinoButton(
                        child: const Text("RESEND OTP"),
                        onPressed: () async {
                          setState(() {
                            _status = Status.Waiting;
                          });
                          _verifyPhoneNumber();
                        })
                  ],
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text("OTP Verification",
                      style: TextStyle(
                          color: const Color(0xFF08C187).withOpacity(0.7),
                          fontSize: 30)),
                ),
                const Text("The code used is invalid!"),
                CupertinoButton(
                    child: const Text("Edit Number"),
                    onPressed: () => Navigator.pop(context)),
                CupertinoButton(
                    child: const Text("Resend Code"),
                    onPressed: () async {
                      setState(() {
                        _status = Status.Waiting;
                      });

                      _verifyPhoneNumber();
                    }),
              ],
            ),
    );
  }
}
