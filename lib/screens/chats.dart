import 'package:chat/screens/chat_detail.dart';
import 'package:chat/states/lib.dart';
// ignore: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  void callChatDetailScreen(BuildContext context, String name, String uid) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                ChatDetail(friendUid: uid, friendName: name)));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (BuildContext context) => CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text("Chats"),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                        chatState.messages.values.toList().map<Widget>((data) {
                  return (ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          // ignore: prefer_if_null_operators
                          usersState.users[data['friendUid']]['picture'] != null
                              ? usersState.users[data['friendUid']]['picture']
                              : ''),
                    ),
                    onTap: () => callChatDetailScreen(
                        context,
                        // ignore: prefer_if_null_operators
                        usersState.users[data['friendUid']]['name'] != null
                            ? usersState.users[data['friendUid']]['name']
                            : '',
                        data['uid']),
                    title: Text(
                        // ignore: prefer_if_null_operators
                        usersState.users[data['friendUid']]['name'] != null
                            ? usersState.users[data['friendUid']]['name']
                            : ''),
                    subtitle: Text(
                        // ignore: prefer_if_null_operators
                        usersState.users[data['friendUid']]['status'] != null
                            ? usersState.users[data['friendUid']]['status']
                            : ''),
                  ));
                }).toList()))
              ],
            ));
  }
}
