import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sipuan_app/screen/beranda.dart';
import 'package:sipuan_app/screen/loadingchatscreen.dart';
import 'package:sipuan_app/screen/loginpage.dart';

import '../model/model.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
    // userSignedIn();
  }

  startLaunching() async {
    final user = FirebaseAuth.instance.currentUser?.uid.characters.toString();
    print("user adalah login " + user.toString());
    if (user == null) {
      return Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
        print("launcher");
      });
    } else {
      return Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => loadingpage()),
            (Route<dynamic> route) => false);
        print("wwW");
      });
    }

    // // final prefs = await SharedPreferences.getInstance();
    // // bool slogin;
    // // slogin = prefs.getBool('slogin');
    // if (slogin == true) {
    //   var duration = const Duration(seconds: 3);
    //   return new Timer(duration, () {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => kelas()),
    //         (Route<dynamic> route) => false);
    //   });
    // } else {
    //   var duration = const Duration(seconds: 3);
    //   return new Timer(duration, () {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => PencakerLogin()),
    //         (Route<dynamic> route) => false);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: -MediaQuery.of(context).size.width / 1,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.height / 1,
              height: MediaQuery.of(context).size.height / 1,
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
                color: Color.fromARGB(255, 241, 78, 127),
              ),
            ),
          ),
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
                color: Color.fromARGB(255, 248, 154, 182),
              ),
            ),
          ),
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
                color: Color.fromARGB(255, 255, 186, 207),
              ),
            ),
          ),
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
                color: Color.fromARGB(255, 247, 197, 212),
              ),
            ),
          ),
          Positioned(
            left: -MediaQuery.of(context).size.width / 1,
            // right: 30,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.height / 1.4,
              height: MediaQuery.of(context).size.height / 1.4,
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
                color: Color.fromARGB(255, 253, 216, 229),
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Image.asset(
                "assets/foto1.png",
                width: MediaQuery.of(context).size.width / 0.8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
