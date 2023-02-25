import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sipuan_app/screen/beritapage.dart';
import 'package:sipuan_app/screen/kontakpage.dart';
import 'package:sipuan_app/screen/contactpage.dart';
import 'package:sipuan_app/screen/pemetaan.dart';
import 'package:sipuan_app/screen/pengaduanpage.dart';
import 'package:sipuan_app/screen/profilpage.dart';

import '../model/model.dart';
import 'chatscreen.dart';
import 'launcher.dart';

class HomePage extends StatefulWidget {
  UserModel user;
  HomePage(this.user, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List menuList = [
    _MenuItem(Icons.chat_bubble, 'CHAT', 1),
    _MenuItem(Icons.holiday_village, 'PENGADUAN', 2),
    _MenuItem(Icons.newspaper, 'BERITA', 3),
    _MenuItem(Icons.map_outlined, 'PEMETAAN', 4),
    _MenuItem(Icons.people_alt, 'PROFIL', 5),
    _MenuItem(Icons.call, 'KONTAK', 6),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / (9 / 2.8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.mirror,
                stops: [
                  0.2,
                  0.4,
                  0.7,
                  0.9,
                ],
                colors: [
                  Color.fromARGB(255, 255, 116, 209),
                  Color.fromARGB(255, 255, 170, 227),
                  Color.fromARGB(255, 255, 116, 209),
                  Color.fromARGB(255, 163, 255, 186),
                ],
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 4))
              ],
            ),
            child: Stack(children: [
              if (MediaQuery.of(context).size.width < 700) ...[
                Positioned(
                  left: MediaQuery.of(context).size.width / 4.5,
                  top: MediaQuery.of(context).size.height / 19,
                  child: Container(
                    child: Image.asset("assets/foto2.png"),
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: const Positioned(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "PEMBERDAYAAN PEREMPUAN DAN PERLINDUNGAN ANAK",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (context) {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         });
          //     FirebaseAuth.instance.signOut();
          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => const LandingPage()),
          //         (Route<dynamic> route) => false);
          //   },
          //   child: const Text("Logout"),
          // ),

          // menu awal
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 10,
          // ),
          // // pengaduan
          // GestureDetector(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 1.6,
          //     height: 50,
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       // border: Border.all(width: 0.5),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Color.fromARGB(31, 0, 0, 0),
          //             spreadRadius: 5,
          //             blurRadius: 5,
          //             offset: Offset(0, 4))
          //       ],
          //     ),
          //     child: Row(children: [
          //       Container(
          //         // color: Colors.pink,
          //         child: const Icon(
          //           Icons.chat_rounded,
          //           size: 40,
          //           color: Colors.white,
          //         ),
          //         height: 50,
          //         width: MediaQuery.of(context).size.width / 6,
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //             // Where the linear gradient begins and ends
          //             begin: Alignment.topLeft,
          //             end: Alignment.bottomRight,
          //             tileMode: TileMode.mirror,
          //             stops: [
          //               0.2,
          //               0.9,
          //             ],
          //             colors: [
          //               Color.fromARGB(255, 255, 116, 209),
          //               Color.fromARGB(255, 247, 1, 255),
          //             ],
          //           ),
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 10),
          //         child: Text(
          //           "Pengaduan",
          //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //         ),
          //       )
          //     ]),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: ((context) =>
          //             PengaduanPage(currentUser: widget.user)),
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // // pemetaan
          // GestureDetector(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 1.6,
          //     height: 50,
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       // border: Border.all(width: 0.5),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Color.fromARGB(31, 0, 0, 0),
          //             spreadRadius: 5,
          //             blurRadius: 5,
          //             offset: Offset(0, 4))
          //       ],
          //     ),
          //     child: Row(children: [
          //       Container(
          //         // color: Colors.pink,
          //         child: const Icon(
          //           Icons.map_sharp,
          //           size: 40,
          //           color: Colors.white,
          //         ),
          //         height: 50,
          //         width: MediaQuery.of(context).size.width / 6,
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //             // Where the linear gradient begins and ends
          //             begin: Alignment.topLeft,
          //             end: Alignment.bottomRight,
          //             tileMode: TileMode.mirror,
          //             stops: [
          //               0.2,
          //               0.9,
          //             ],
          //             colors: [
          //               Color.fromARGB(255, 255, 116, 209),
          //               Color.fromARGB(255, 247, 1, 255),
          //             ],
          //           ),
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 10),
          //         child: SizedBox(
          //           width: 150,
          //           child: AutoSizeText(
          //             "Pemetaan Pembinaan PAA",
          //             style:
          //                 TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //             maxLines: 2,
          //           ),
          //         ),
          //       )
          //     ]),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: ((context) => PemetaanPage()),
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          // GestureDetector(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width / 1.6,
          //     height: 50,
          //     decoration: const BoxDecoration(
          //       color: Colors.white,
          //       // border: Border.all(width: 0.5),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Color.fromARGB(31, 0, 0, 0),
          //             spreadRadius: 5,
          //             blurRadius: 5,
          //             offset: Offset(0, 4))
          //       ],
          //     ),
          //     child: Row(children: [
          //       Container(
          //         // color: Colors.pink,
          //         child: const Icon(
          //           Icons.newspaper_sharp,
          //           size: 40,
          //           color: Colors.white,
          //         ),
          //         height: 50,
          //         width: MediaQuery.of(context).size.width / 6,
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //             // Where the linear gradient begins and ends
          //             begin: Alignment.topLeft,
          //             end: Alignment.bottomRight,
          //             tileMode: TileMode.mirror,
          //             stops: [
          //               0.2,
          //               0.9,
          //             ],
          //             colors: [
          //               Color.fromARGB(255, 255, 116, 209),
          //               Color.fromARGB(255, 247, 1, 255),
          //             ],
          //           ),
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 10),
          //         child: Text(
          //           "Berita",
          //           style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //         ),
          //       )
          //     ]),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: ((context) => BeritaPage()),
          //       ),
          //     );
          //   },
          // ),

          Container(
            height: MediaQuery.of(context).size.height / (9 / 6),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  // crossAxisSpacing: 60,
                ),
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  return InkWell(
                      onTap: () async {
                        if (menuList[position].id == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(currentUser: widget.user)));
                        } else if (menuList[position].id == 2) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PengaduanPage(currentUser: widget.user)));
                        } else if (menuList[position].id == 3) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BeritaPage()));
                        } else if (menuList[position].id == 4) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PemetaanPage()));
                        } else if (menuList[position].id == 5) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilPage(widget.user)),
                              (Route<dynamic> route) => false);
                        } else if (menuList[position].id == 6) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => KontakPage()));
                        } else if (menuList[position].id == 7) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilPage(widget.user)));
                        }
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                // border: Border.all(width: 3, color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(7)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return RadialGradient(
                                      center: Alignment.topLeft,
                                      radius: 1,
                                      colors: <Color>[
                                        Color.fromARGB(255, 255, 116, 209),
                                        Color.fromARGB(255, 255, 170, 227),
                                        Color.fromARGB(255, 255, 116, 209),
                                        Color.fromARGB(255, 163, 255, 186),
                                      ],
                                      tileMode: TileMode.mirror,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    menuList[position].icon,
                                    size: 90,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                Text(
                                  menuList[position].title,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
                itemCount: menuList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final int id;

  _MenuItem(this.icon, this.title, this.id);
}
