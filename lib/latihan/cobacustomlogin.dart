import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:sipuan_app/model/model.dart';
import 'package:sipuan_app/screen/beranda.dart';
import 'package:sipuan_app/screen/launcher.dart';
import 'package:sipuan_app/screen/loadingchatscreen.dart';
import 'package:sipuan_app/screen/registerpage.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({super.key});

  @override
  State<LoginPhonePage> createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {
  bool lihat = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lupaemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black45,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
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
          // menu
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // logo
                Container(
                  // width: MediaQuery.of(context).size.width / 20,
                  height: MediaQuery.of(context).size.width / 6,
                  child: Image.asset("assets/foto2.png"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 24,
                ),
                // tulisan
                const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w900),
                ),
                // kotak
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10,
                    top: MediaQuery.of(context).size.width / 20,
                  ),
                  // kotak transparant
                  child: Container(
                    alignment: Alignment.center,
                    // height: MediaQuery.of(context).size.height / 3.4,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(144, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: Column(
                            children: [
                              // ignore: prefer_const_constructors
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                // ignore: prefer_const_constructors
                                child: Align(
                                  // ignore: sort_child_properties_last
                                  child: const Text(
                                    "No HP",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              // email
                              Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      // Where the linear gradient begins and ends
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomRight,
                                      // tileMode: TileMode.mirror,
                                      colors: [
                                        Color.fromARGB(255, 67, 121, 223),
                                        Color.fromARGB(255, 240, 122, 157),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                // ignore: prefer_const_constructors
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextField(
                                    controller: email,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 2.0,
                                          horizontal: 4.0,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                        ),
                                        icon: Padding(
                                          padding: EdgeInsets.only(
                                            left: 4,
                                            right: 0,
                                          ),
                                          child: Icon(
                                            Icons.email_outlined,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Ketikan Disini"),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .verifyPhoneNumber(
                                            phoneNumber: "+${email.text}",
                                            verificationCompleted:
                                                (credential) async {
                                              await FirebaseAuth.instance
                                                  .signInWithCredential(
                                                      credential);
                                            },
                                            verificationFailed: (exception) {
                                              tampilsnackbar(context,
                                                  exception.message.toString());
                                              print(exception.message);
                                            },
                                            codeSent: (verificationId,
                                                resendCode) async {
                                              String? smsCode =
                                                  await askingSMSCode(context);
                                              if (smsCode != null) {
                                                PhoneAuthCredential credential =
                                                    PhoneAuthProvider
                                                        .credential(
                                                            verificationId:
                                                                verificationId,
                                                            smsCode: smsCode);
                                                try {
                                                  FirebaseAuth.instance
                                                      .signInWithCredential(
                                                          credential);
                                                } on FirebaseAuthException catch (e) {
                                                  log(e.message.toString());
                                                }
                                              }
                                            },
                                            codeAutoRetrievalTimeout:
                                                ((verificationId) {}));
                                  },
                                  child: Text("login phone"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _displayresetPassword(context);
                          },
                          child: const Text(
                            "Lupa Kata Sandi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const RegisterPage()),
                              ),
                            );
                          },
                          child: const Text(
                            "daftar akun",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void tampilsnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 250, 5, 5),
        content: Text(
          message.toString(),
        ),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ),
    );
  }

  Future<String?> askingSMSCode(BuildContext context) async {
    return await showDialog<String>(
        context: context,
        builder: (_) {
          TextEditingController controller = TextEditingController();

          return SimpleDialog(
              title: const Text('Please enter the SMS code sent to you'),
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  color: const Color.fromARGB(255, 240, 240, 240),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.green,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'SMS Code'),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, controller.text);
                    },
                    child: Text('Confirm',
                        style: TextStyle(color: Colors.green.shade900)))
              ]);
        });
  }

  void tampilsnackbarlupapassword(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 64, 109, 255),
        content: Text("Link Reset Password Sudah dikirim, silahkan buka email"),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ),
    );
  }

  void tampilsnackbarverifikasi(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 64, 109, 255),
        content: Text("User anda belum di verifikasi admin"),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ),
    );
  }

  Future lupaspassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: lupaemail.text);
      tampilsnackbarlupapassword(context);
      setState(() {
        lupaemail..text = "";
      });
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      tampilsnackbar(context, e.message.toString());
    }
  }

  Future<void> _displayresetPassword(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Reset Password'),
            content: TextField(
              controller: lupaemail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Masukkan Email"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () async {
                  lupaspassword();
                },
              ),
            ],
          );
        });
  }
}
