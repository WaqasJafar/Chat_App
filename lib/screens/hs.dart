// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const Text("\nProducts"),
//             StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection("user").snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasData) {
//                   final snap = snapshot.data!.docs;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     primary: false,
//                     itemCount: snap.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         height: 70,
//                         width: double.infinity,
//                         margin: const EdgeInsets.only(bottom: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.black26,
//                               offset: Offset(2, 2),
//                               blurRadius: 10,
//                             ),
//                           ],
//                         ),
//                         child: Stack(
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.only(left: 20),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 snap[index]['name'],
//                                 style: const TextStyle(
//                                   color: Colors.black54,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             // Container(
//                             //   margin: const EdgeInsets.only(right: 20),
//                             //   alignment: Alignment.centerRight,
//                             //   child: Text(
//                             //     "\$${snap[index]['price']}",
//                             //     style: TextStyle(
//                             //       color: Colors.green.withOpacity(0.7),
//                             //       fontWeight: FontWeight.bold,
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return const SizedBox();
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'chat_screen.dart';

class MainScreen extends StatefulWidget {
  UserModel user;
  MainScreen(this.user, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name = "";
  List<Map> searchResult = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .where('name', isNotEqualTo: widget.user.name)
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return ListTile(
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            currentUser: widget.user,
                                            friendId: data['uid'],
                                            friendName: data['name'],
                                            friendImage: data['image'])));
                              },
                              icon: const Icon(Icons.message)),
                        );
                      }
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return ListTile(
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            currentUser: widget.user,
                                            friendId: data[index]['uid'],
                                            friendName: data[index]['name'],
                                            friendImage: data[index]
                                                ['image'])));
                              },
                              icon: const Icon(Icons.message)),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
