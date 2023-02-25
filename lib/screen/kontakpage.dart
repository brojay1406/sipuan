import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../model/icon_menu.dart';
import 'launcher.dart';
import 'loadingprofilpage.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  int nomor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 1,
          decoration: const BoxDecoration(
            // Box decoration takes a gradient
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              colors: [
                Color.fromARGB(255, 255, 128, 167),
                Color.fromARGB(255, 171, 201, 255)
              ],
            ),
          ),
        ),

        // kotak besar
        Positioned(
          left: -MediaQuery.of(context).size.width / 2,
          top: -MediaQuery.of(context).size.width / 0.5,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.height / 1,
            height: MediaQuery.of(context).size.height / 1,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 238, 27, 143),
            ),
          ),
        ),
        // kotak kedua
        Positioned(
          left: -MediaQuery.of(context).size.width / 2.3,
          top: -MediaQuery.of(context).size.width / 0.5,

          // top: -getSmallDiameter(context) / ,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.height / 1.1,
            height: MediaQuery.of(context).size.height / 1.1,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.all(Radius.circular(720)),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color.fromARGB(255, 255, 128, 167),
              //       Colors.blueGrey
              //     ])
              color: Color.fromARGB(255, 255, 71, 172),
            ),
          ),
        ),
        // //kotak ketiga
        Positioned(
          left: -MediaQuery.of(context).size.width / 2.7,
          top: -MediaQuery.of(context).size.width / 0.5,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.height / 1.2,
            height: MediaQuery.of(context).size.height / 1.2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.all(Radius.circular(1000)),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color.fromARGB(255, 255, 128, 167),
              //       Colors.blueGrey
              //     ])
              color: Color.fromARGB(255, 214, 97, 162),
            ),
          ),
        ),
        // // kotak keempat
        Positioned(
          left: -MediaQuery.of(context).size.width / 3,
          top: -MediaQuery.of(context).size.width / 0.5,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.height / 1.3,
            height: MediaQuery.of(context).size.height / 1.3,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.all(Radius.circular(1000)),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color.fromARGB(255, 255, 128, 167),
              //       Colors.blueGrey
              //     ])
              color: Color.fromARGB(255, 235, 167, 204),
            ),
          ),
        ),
        //kotak ke5
        Positioned(
          left: -MediaQuery.of(context).size.width / 3.4,
          // right: 30,
          top: -MediaQuery.of(context).size.width / 0.5,
          bottom: 0,
          child: Hero(
            tag: 'duapuluh',
            // placeholderBuilder: ,
            child: Container(
              width: MediaQuery.of(context).size.height / 1.4,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp,
                  colors: [
                    Color.fromARGB(255, 255, 208, 222),
                    Color.fromARGB(255, 255, 137, 226)
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 6,
          left: MediaQuery.of(context).size.width / 6,
          child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height / 1,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "KONTAK",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: Divider(
                        thickness: 3,
                        color: Colors.white,
                        endIndent: MediaQuery.of(context).size.width / 8,
                        indent: MediaQuery.of(context).size.width / 8,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: StreamBuilder(
                        stream: db.collection('kontak').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return new Text("Loading");
                          }
                          var userDocument = snapshot.data;
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                var idkontak = snapshot.data?.docs[index].id;
                                // var lastMsg =
                                //     snapshot.data?.docs[index]['judul_berita'];
                                return FutureBuilder(
                                    future: FirebaseFirestore.instance
                                        .collection('kontak')
                                        .doc(idkontak)
                                        .get(),
                                    builder:
                                        (context, AsyncSnapshot asynSnapshot) {
                                      if (asynSnapshot.hasData) {
                                        var kontak = asynSnapshot.data;
                                        return InkWell(
                                          onTap: () {
                                            UrlLauncher.launch(
                                                'tel:${kontak['nomor']}');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  gradient:
                                                      const LinearGradient(
                                                    // Where the linear gradient begins and ends
                                                    begin: Alignment.topRight,
                                                    end: Alignment.bottomRight,
                                                    // tileMode: TileMode.mirror,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 67, 121, 223),
                                                      Color.fromARGB(
                                                          255, 240, 122, 157),
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              // ignore: prefer_const_constructors
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 15),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: Icon(
                                                        Icons.phone,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      height: 60,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  0),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          kontak['nama'],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return LinearProgressIndicator();
                                    });
                              });
                        },
                      ),
                    ),
                  ],
                )),
          ),
        )
        // button back
      ]),
    );
  }
}

// ListView(
//                     children: [
//                       ElevatedButton(
//                           onPressed: () {
//                             UrlLauncher.launch('tel:+081277797723');
//                           },
//                           child: Text("Telp")),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 30,
//                       ),
//                       const Center(
//                         child: Text(
//                           "KONTAK",
//                           style: TextStyle(
//                             fontSize: 60,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 5,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 2,
//                           decoration: BoxDecoration(
//                             gradient: const LinearGradient(
//                               // Where the linear gradient begins and ends
//                               begin: Alignment.topRight,
//                               end: Alignment.bottomRight,
//                               // tileMode: TileMode.mirror,
//                               colors: [
//                                 Color.fromARGB(255, 67, 121, 223),
//                                 Color.fromARGB(255, 240, 122, 157),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(0),
//                           ),
//                           // ignore: prefer_const_constructors
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 15),
//                                 child: Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: Icon(
//                                     Icons.phone,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: Container(
//                                   height: 30,
//                                   width: MediaQuery.of(context).size.width / 2,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(0),
//                                       bottomRight: Radius.circular(0),
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       userDocument!["telepon"],
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 2,
//                           decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 // Where the linear gradient begins and ends
//                                 begin: Alignment.topRight,
//                                 end: Alignment.bottomRight,
//                                 // tileMode: TileMode.mirror,
//                                 colors: [
//                                   Color.fromARGB(255, 67, 121, 223),
//                                   Color.fromARGB(255, 240, 122, 157),
//                                 ],
//                               ),
//                               borderRadius: BorderRadius.circular(0)),
//                           // ignore: prefer_const_constructors
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 15),
//                                 child: Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: Icon(
//                                     Icons.phone,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: Container(
//                                   height: 30,
//                                   width: MediaQuery.of(context).size.width / 2,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(0),
//                                       bottomRight: Radius.circular(0),
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       userDocument["whatsapp"],
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       // alamat
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width / 2,
//                           decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 // Where the linear gradient begins and ends
//                                 begin: Alignment.topRight,
//                                 end: Alignment.bottomRight,
//                                 // tileMode: TileMode.mirror,
//                                 colors: [
//                                   Color.fromARGB(255, 67, 121, 223),
//                                   Color.fromARGB(255, 240, 122, 157),
//                                 ],
//                               ),
//                               borderRadius: BorderRadius.circular(0)),
//                           // ignore: prefer_const_constructors
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 15),
//                                 child: Container(
//                                   height: 30,
//                                   width: 30,
//                                   child: Icon(
//                                     Icons.location_city,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: Container(
//                                   height: 30,
//                                   width: MediaQuery.of(context).size.width / 2,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(0),
//                                       bottomRight: Radius.circular(0),
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       userDocument["alamat"],
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );