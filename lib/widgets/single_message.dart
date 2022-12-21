import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const SingleMessage(
      {super.key,
      required this.message,
      required this.isMe,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: isMe ? Colors.black : Colors.orange,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                12,
              ),
            ),
          ),
          // child: Text(
          //   message,
          //   style: const TextStyle(
          //     color: Colors.white,
          //   ),
          // )
          child: Column(
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 0.0,
                ),
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
