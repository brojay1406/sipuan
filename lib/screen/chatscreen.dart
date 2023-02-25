import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sipuan_app/model/model.dart';

import '../model/icon_menu.dart';
import '../widget/message_textfield.dart';
import '../widget/single_message.dart';
import 'launcher.dart';
import 'loadingprofilpage.dart';

class ChatScreen extends StatelessWidget {
  final UserModel currentUser;
  // final String friendId;
  // final String friendName;
  // final String friendImage;
  ChatScreen({
    required this.currentUser,
    // required this.friendId,
    // required this.friendName,
    // required this.friendImage,
  });
  var nomor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<IconMenu>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) {
              switch (value) {
                case IconsMenu.ProfilButton:
                  print('2');
                  nomor = 2;
                  break;
                case IconsMenu.Logout:
                  print('23');
                  nomor = 1;

                  break;
              }
              if (nomor == 1) {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                    (Route<dynamic> route) => false);
              } else if (nomor == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const loadingpageProfl()),
                );
              }
            },
            itemBuilder: (context) => IconsMenu.items
                .map((item) => PopupMenuItem<IconMenu>(
                      value: item,
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(item.icon, color: Colors.pink),
                        title: Text(item.text),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            // padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  // tileMode: TileMode.clamp,
                  colors: [
                    Color.fromARGB(255, 255, 128, 167),
                    Color.fromARGB(255, 171, 201, 255)
                  ],
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height / 22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: Row(
                          children: [
                            // IconButton(
                            //   icon: Icon(
                            //     Icons.arrow_back,
                            //     color: Colors.white,
                            //     size: 30,
                            //   ),
                            //   onPressed: () {
                            //     Navigator.pop(context);
                            //   },
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  // Where the linear gradient begins and ends
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  // tileMode: TileMode.clamp,
                                  colors: [
                                    Color.fromARGB(255, 255, 128, 167),
                                    Color.fromARGB(255, 171, 201, 255)
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Admin",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.more_vert,
                      //     color: Colors.white,
                      //     size: 30,
                      //   ),
                      // )
                    ],
                  ),
                ),
                Positioned(
                  left: -MediaQuery.of(context).size.width / 0.9,
                  top: MediaQuery.of(context).size.height / 8,
                  // bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.height / 0.5,
                    height: MediaQuery.of(context).size.height / 0.5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 235, 235, 235),
                    ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.uid)
                      .collection("messages")
                      // .doc('ibHr3iGCZBQhUX7ZiW3G1rKS2fd2')
                      .doc('JWkjx78n7udJRyeuglm8B6Wa51r1')
                      .collection("chats")
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print(currentUser.uid);
                      if (snapshot.data.docs.length < 1) {
                        return Center(
                          child: Text("Kirim pesan disini"),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isMe = snapshot.data.docs[index]['senderId'] ==
                                currentUser.uid;
                            return SingleMessage(
                              message: snapshot.data.docs[index]["message"],
                              isMe: isMe,
                              waktu: snapshot.data.docs[index]["date"],
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          )),
          MessageTextField(currentUser.uid, 'JWkjx78n7udJRyeuglm8B6Wa51r1')
        ],
      ),
    );
  }
}
