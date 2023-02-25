import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sipuan_app/screen/detailberitapage.dart';

import '../model/icon_menu.dart';
import 'launcher.dart';
import 'loadingprofilpage.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
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
          left: -MediaQuery.of(context).size.width / 1,
          top: 0,
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
          left: -MediaQuery.of(context).size.width / 1,
          top: 0,

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
        //kotak ketiga
        Positioned(
          left: -MediaQuery.of(context).size.width / 1,
          top: 0,
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
        // kotak keempat
        Positioned(
          left: -MediaQuery.of(context).size.width / 1,
          top: 0,
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
          left: -MediaQuery.of(context).size.width / 1,
          // right: 30,
          top: 0,
          bottom: 0,
          child: Hero(
            tag: 'duapuluh',
            // placeholderBuilder: ,
            child: Container(
              width: MediaQuery.of(context).size.height / 1.4,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 235, 175, 196),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          child: Container(
            height: MediaQuery.of(context).size.height / 1,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Center(
                  child: Text(
                    "BERITA",
                    style: TextStyle(
                      fontSize: 30,
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
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height / 5),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('berita')
                        .where("status", isEqualTo: 1)
                        .snapshots(),
                    builder: ((context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length < 1) {
                          return Center(
                            child: Text("Belum ada Pesan"),
                          );
                        }
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var friendId =
                                  snapshot.data.docs[index]['id_berita'];
                              var lastMsg =
                                  snapshot.data.docs[index]['judul_berita'];
                              return FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection('berita')
                                      .doc(friendId)
                                      .get(),
                                  builder:
                                      (context, AsyncSnapshot asynSnapshot) {
                                    if (asynSnapshot.hasData) {
                                      var berita = asynSnapshot.data;
                                      return Card(
                                        color:
                                            Color.fromARGB(97, 248, 121, 252),
                                        clipBehavior: Clip.antiAlias,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        20,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                                child: Image(
                                                  image: NetworkImage(
                                                    berita["image"],
                                                  ),
                                                  // height: 200,

                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              //  leading: Icon(Icons.arrow_drop_down_circle),
                                              title: Text(
                                                berita['judul_berita'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 25),
                                              ),

                                              subtitle: Text(
                                                // ignore: prefer_interpolation_to_compose_strings
                                                berita['tanggal_berita']
                                                        .toDate()
                                                        .year
                                                        .toString() +
                                                    "-" +
                                                    berita['tanggal_berita']
                                                        .toDate()
                                                        .month
                                                        .toString() +
                                                    "-" +
                                                    berita['tanggal_berita']
                                                        .toDate()
                                                        .day
                                                        .toString() +
                                                    " " +
                                                    berita['tanggal_berita']
                                                        .toDate()
                                                        .hour
                                                        .toString() +
                                                    ":" +
                                                    berita['tanggal_berita']
                                                        .toDate()
                                                        .minute
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6)),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DetailBerita(
                                                            berita['image'],
                                                            berita[
                                                                'isi_berita'],
                                                            berita[
                                                                'judul_berita'],
                                                            berita['tanggal_berita']
                                                                .toString())));
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: AutoSizeText(
                                                berita['isi_berita'],
                                                maxLines: 2,
                                                minFontSize: 16,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.6)),
                                              ),
                                            ),
                                            ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: Color(
                                                        0xFF6200EE), // foreground
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailBerita(
                                                                    berita[
                                                                        'image'],
                                                                    berita[
                                                                        'isi_berita'],
                                                                    berita[
                                                                        'judul_berita'],
                                                                    berita[
                                                                        'tanggal_berita'])));
                                                  },
                                                  child: const Text(
                                                      'Baca Selengkapnya'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return LinearProgressIndicator();
                                  });
                            });
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        )
        // button back
      ]),
    );
  }
}
