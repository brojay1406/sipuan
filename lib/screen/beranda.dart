import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sipuan_app/screen/chatscreen.dart';
import 'package:sipuan_app/screen/homepage.dart';
import 'package:sipuan_app/screen/kontakpage.dart';
import 'package:sipuan_app/screen/contactpage.dart';
import 'package:sipuan_app/screen/launcher.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:sipuan_app/screen/loginpage.dart';
import 'package:sipuan_app/screen/pemetaan.dart';
import '../model/model.dart';

class Beranda extends StatefulWidget {
  UserModel user;
  Beranda(this.user, {super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  late UserModel user = widget.user;

  @override
  String userdata = '';
  // final tabs = [HomePage(), LoginPage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<int> _badgeCounts = List<int>.generate(5, (index) => index);
    List<bool> _badgeShows = List<bool>.generate(5, (index) => true);

    return Scaffold(
      // backgroundColor: Colors.black45,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          // Container(
          //   width: MediaQuery.of(context).size.width / 1,
          //   height: MediaQuery.of(context).size.height / 1,
          //   decoration: const BoxDecoration(
          //     // Box decoration takes a gradient
          //     gradient: LinearGradient(
          //       // Where the linear gradient begins and ends
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomCenter,
          //       tileMode: TileMode.clamp,
          //       colors: [
          //         Color.fromARGB(255, 255, 128, 167),
          //         Color.fromARGB(255, 171, 201, 255)
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: -MediaQuery.of(context).size.width / 1,
          //   top: 0,
          //   bottom: 0,
          //   child: Container(
          //     width: MediaQuery.of(context).size.height / 1,
          //     height: MediaQuery.of(context).size.height / 1,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Color.fromARGB(255, 238, 27, 143),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: -MediaQuery.of(context).size.width / 1,
          //   top: 0,

          //   // top: -getSmallDiameter(context) / ,
          //   bottom: 0,
          //   child: Container(
          //     width: MediaQuery.of(context).size.height / 1.1,
          //     height: MediaQuery.of(context).size.height / 1.1,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       // borderRadius: BorderRadius.all(Radius.circular(720)),
          //       // gradient: LinearGradient(
          //       //     begin: Alignment.topCenter,
          //       //     end: Alignment.bottomCenter,
          //       //     colors: [
          //       //       Color.fromARGB(255, 255, 128, 167),
          //       //       Colors.blueGrey
          //       //     ])
          //       color: Color.fromARGB(255, 255, 71, 172),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: -MediaQuery.of(context).size.width / 1,
          //   top: 0,
          //   bottom: 0,
          //   child: Container(
          //     width: MediaQuery.of(context).size.height / 1.2,
          //     height: MediaQuery.of(context).size.height / 1.2,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       // borderRadius: BorderRadius.all(Radius.circular(1000)),
          //       // gradient: LinearGradient(
          //       //     begin: Alignment.topCenter,
          //       //     end: Alignment.bottomCenter,
          //       //     colors: [
          //       //       Color.fromARGB(255, 255, 128, 167),
          //       //       Colors.blueGrey
          //       //     ])
          //       color: Color.fromARGB(255, 214, 97, 162),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: -MediaQuery.of(context).size.width / 1,
          //   top: 0,
          //   bottom: 0,
          //   child: Container(
          //     width: MediaQuery.of(context).size.height / 1.3,
          //     height: MediaQuery.of(context).size.height / 1.3,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       // borderRadius: BorderRadius.all(Radius.circular(1000)),
          //       // gradient: LinearGradient(
          //       //     begin: Alignment.topCenter,
          //       //     end: Alignment.bottomCenter,
          //       //     colors: [
          //       //       Color.fromARGB(255, 255, 128, 167),
          //       //       Colors.blueGrey
          //       //     ])
          //       color: Color.fromARGB(255, 235, 167, 204),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: -MediaQuery.of(context).size.width / 1,
          //   // right: 30,
          //   top: 0,
          //   bottom: 0,
          //   child: Hero(
          //     tag: 'duapuluh',
          //     // placeholderBuilder: ,
          //     child: Container(
          //       width: MediaQuery.of(context).size.height / 1.4,
          //       height: MediaQuery.of(context).size.height / 1.4,
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Color.fromARGB(255, 235, 175, 196),
          //       ),
          //     ),
          //   ),
          // ),
          // Center(
          //   child: Column(
          //     children: [
          //       ElevatedButton(
          //         onPressed: () {
          //           showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return const Center(
          //                   child: CircularProgressIndicator(),
          //                 );
          //               });
          //           FirebaseAuth.instance.signOut();
          //           Navigator.of(context).pop();
          //           Navigator.of(context).pushAndRemoveUntil(
          //               MaterialPageRoute(
          //                   builder: (context) => const LandingPage()),
          //               (Route<dynamic> route) => false);
          //         },
          //         child: const Text("Logout"),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           // getuser();
          //           print(widget.user);
          //           // Navigator.push(
          //           //   context,
          //           //   MaterialPageRoute(
          //           //     builder: ((context) =>
          //           //         ChatScreen(currentUser: widget.user)),
          //           //   ),
          //           // );
          //         },
          //         child: const Text("Logout"),
          //       ),
          //     ],
          //   ),
          // ),
          // // menu
          if (_currentIndex == 0) ...[
            HomePage(user)
          ] else if (_currentIndex == 1) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ChatScreen(currentUser: user),
            )
          ] else if (_currentIndex == 2) ...[
            PemetaanPage()
          ] else if (_currentIndex == 3) ...[
            KontakPage()
          ],
          // Positioned(
          //   bottom: 0,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //         gradient: LinearGradient(
          //           // Where the linear gradient begins and ends
          //           begin: Alignment.topRight,
          //           end: Alignment.bottomCenter,
          //           tileMode: TileMode.clamp,
          //           colors: [
          //             Color.fromARGB(255, 255, 128, 167),
          //             Color.fromARGB(255, 171, 201, 255)
          //           ],
          //         ),
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(30),
          //             topRight: Radius.circular(30))),
          //     width: MediaQuery.of(context).size.width / 1,
          //     child: CustomNavigationBar(
          //       elevation: 0.0,
          //       iconSize: 30.0,
          //       selectedColor: Color.fromARGB(255, 247, 8, 155),
          //       strokeColor: Color.fromARGB(255, 201, 13, 169),
          //       unSelectedColor: Color.fromARGB(255, 14, 14, 14),
          //       backgroundColor: Colors.transparent,
          //       borderRadius: const Radius.circular(10),
          //       items: [
          //         CustomNavigationBarItem(
          //             icon: const Icon(
          //               Icons.home,
          //             ),
          //             title: Text("Beranda")),
          //         CustomNavigationBarItem(
          //             icon: const Icon(Icons.chat_rounded),
          //             title: Text("Pesan")),
          //         CustomNavigationBarItem(
          //             icon: const Icon(Icons.lightbulb_outline),
          //             title: Text(
          //               "Halaman Pemetaan",
          //               style: TextStyle(fontSize: 10),
          //             )),
          //         CustomNavigationBarItem(
          //             icon: const Icon(Icons.phone_rounded),
          //             title: Text("Kontak")),
          //       ],
          //       currentIndex: _currentIndex,
          //       onTap: (index) {
          //         setState(() {
          //           _currentIndex = index;

          //           print(_currentIndex);
          //         });
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
