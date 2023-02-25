import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:sipuan_app/latihan/cobacustomlogin.dart';
import 'package:sipuan_app/model/model.dart';
import 'package:sipuan_app/screen/beranda.dart';
import 'package:sipuan_app/screen/launcher.dart';
import 'package:sipuan_app/screen/loadingchatscreen.dart';
import 'package:sipuan_app/screen/registerpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool lihat = false;
  List<Map> searchResult = [];
  bool circularlihat = true;
  TextEditingController noktp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController lupaemail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black45,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 0.5,
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
                child: Container(
              // decoration: BoxDecoration(border: Border.all(width: 5)),
              width: MediaQuery.of(context).size.width / 1,
              height: MediaQuery.of(context).size.height / 1,
              child: Stack(children: [
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
              ]),
            )),
            // menu
            SingleChildScrollView(
              child: Positioned(
                left: 0,
                right: 0,
                top: MediaQuery.of(context).size.height / 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 7,
                    ),
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
                            borderRadius: BorderRadius.circular(0)),
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
                                      child: ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            // Where the linear gradient begins and ends
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            // tileMode: TileMode.mirror,
                                            colors: [
                                              Color.fromARGB(255, 67, 121, 223),
                                              Color.fromARGB(
                                                  255, 240, 122, 157),
                                            ],

                                            tileMode: TileMode.mirror,
                                          ).createShader(bounds);
                                        },
                                        child: const Text(
                                          "NIK",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold),
                                        ),
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
                                        borderRadius: BorderRadius.circular(0)),
                                    // ignore: prefer_const_constructors
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        controller: noktp,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 2.0,
                                              horizontal: 4.0,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0)),
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
                                ],
                              ),
                            ),
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
                                      child: ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return LinearGradient(
                                            // Where the linear gradient begins and ends
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                            // tileMode: TileMode.mirror,
                                            colors: [
                                              Color.fromARGB(255, 67, 121, 223),
                                              Color.fromARGB(
                                                  255, 240, 122, 157),
                                            ],

                                            tileMode: TileMode.mirror,
                                          ).createShader(bounds);
                                        },
                                        child: const Text(
                                          "Kata Sandi",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),

                                  // password
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          // Where the linear gradient begins and ends
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // tileMode: TileMode.clamp,
                                          colors: [
                                            Color.fromARGB(255, 67, 121, 223),
                                            Color.fromARGB(255, 240, 122, 157),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      // ignore: prefer_const_constructors
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextField(
                                          controller: password,
                                          obscureText: !lihat ? true : false,
                                          decoration: InputDecoration(
                                            disabledBorder: InputBorder.none,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 2.0,
                                              horizontal: 4.0,
                                            ),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0)),
                                            ),
                                            icon: const Padding(
                                              padding: EdgeInsets.only(
                                                left: 4,
                                                right: 0,
                                              ),
                                              child: Icon(
                                                Icons.lock_outline_sharp,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: "Ketikan Disini",
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (lihat) {
                                                    lihat = false;
                                                  } else {
                                                    lihat = true;
                                                  }
                                                });
                                              },
                                              icon: !lihat
                                                  ? Icon(Icons.remove_red_eye)
                                                  : Icon(Icons
                                                      .remove_red_eye_rounded),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // button
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.transparent,
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Center(
                                                child: Visibility(
                                                    visible: circularlihat,
                                                    child:
                                                        CircularProgressIndicator()),
                                              );
                                            });
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: ((context) =>
                                        //         const LoginPhonePage()),
                                        //   ),
                                        // );
                                        setState(() {
                                          setState(() {
                                            searchResult = [];
                                          });
                                        });

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .where("noktp",
                                                isEqualTo: noktp.text)
                                            .get()
                                            .then((value) async {
                                          if (value.docs.length < 1) {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                            tampilsnackbarverifikasi(
                                                context, "NIK tidak ditemukan");

                                            return;
                                          }
                                          String aaa = value.docs.toString();
                                          UserModellogin bbbb;
                                          value.docs.forEach((user) async {
                                            bbbb =
                                                UserModellogin.fromJson(user);
                                            print("login['email']");
                                            print(bbbb.email);
                                            print("login['email']");
                                            // showDialog(
                                            //     context: context,
                                            //     builder: (context) {
                                            //       return Center(
                                            //         child:
                                            //             CircularProgressIndicator(),
                                            //       );
                                            //     });
                                            try {
                                              final user = (await FirebaseAuth
                                                      .instance
                                                      .signInWithEmailAndPassword(
                                                          email: bbbb.email,
                                                          password: password
                                                              .text
                                                              .trim()))
                                                  .user;
                                              DocumentSnapshot userData =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(user?.uid)
                                                      .get();

                                              UserModel userModel =
                                                  UserModel.fromJson(userData);
                                              print("objectasdasdas");
                                              print(userModel.verif);
                                              var verif = userModel.verif;

                                              if (verif == '1') {
                                                if (user != null) {
                                                  tampilsnackbarverifikasi(
                                                      context,
                                                      "Login Berhasil");
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  loadingpage()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                } else {}
                                              } else {
                                                tampilsnackbarverifikasi(
                                                    context,
                                                    "User anda belum di verifikasi admin");
                                                FirebaseAuth.instance.signOut();
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              }
                                            } on FirebaseAuthException catch (e) {
                                              Navigator.of(context).pop();
                                              print(e);
                                              if (e.toString() ==
                                                  "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
                                                print("vdvdjfds");
                                                tampilsnackbar(
                                                    context, "password salah");
                                              }
                                              tampilsnackbar(
                                                  context, e.toString());
                                            }
                                          });

                                          print("login['email']");
                                          // print(bbbb.email);
                                          print("login['email']");
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              // Where the linear gradient begins and ends
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              // tileMode: TileMode.clamp,
                                              colors: [
                                                Color.fromARGB(
                                                    255, 67, 121, 223),
                                                Color.fromARGB(
                                                    255, 240, 122, 157),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Center(
                                            child: Text(
                                              "MASUK",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const RegisterPage()),
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
            ),
          ],
        ),
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

  void tampilsnackbarverifikasi(BuildContext context, String tulisan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 64, 109, 255),
        content: Text(tulisan),
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
