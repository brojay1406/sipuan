import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  // AuthCredential emailregistrasi =
  //     EmailAuthProvider.credential(email: '', password: '');
  bool lihat = false;
  bool newvalue = false;
  String emailya = "";
  File? _image;
  UploadTask? uploadTask;
  TextEditingController namaController = TextEditingController();
  TextEditingController noktpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController ponselController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future Registrasi() async {
    var lihat = true;
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    await FirebaseFirestore.instance
        .collection("users")
        .where("noktp", isEqualTo: noktpController.text)
        .get()
        .then((value) async {
      print("valeueeef");
      print(value);
      print("valeueeef");
      if (value.docs.length < 1) {
        try {
          if (emailController.text == "") {
            emailya = noktpController.text + "@email.com";
          } else {
            emailya = emailController.text;
          }
          final emailregistrasi = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailya, password: passwordController.text);
          final ambildata =
              FirebaseAuth.instance.currentUser?.uid.characters.toString();
          print(ambildata);
          final nama_foto = "fotoktp/$ambildata-${namaController.text}.jpg";
          final file_foto = File(_image!.path);
          final upload_foto = FirebaseStorage.instance.ref().child(nama_foto);
          uploadTask = upload_foto.putFile(file_foto);
          final snapshot = await uploadTask!.whenComplete(() {});
          final link_foto = await snapshot.ref.getDownloadURL();
          print(link_foto);
          await db.collection("users").doc(ambildata).set({
            'name': namaController.text,
            'noktp': noktpController.text,
            'alamat': alamatController.text,
            'ponsel': ponselController.text,
            'email': emailya,
            'uid': ambildata,
            'date_register': DateTime.now(),
            'image': link_foto,
            'verif': '0',
          });

          tampilsnackbar(context, "registrasi berhasil", Colors.green);
          FirebaseAuth.instance.signOut();
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false);
        } on FirebaseAuthException catch (e) {
          Navigator.of(context, rootNavigator: true).pop();

          tampilsnackbarnoktp(context, e.toString());
          lihat = false;
          // setState(() {
          //   // context;
          // });
        }
      } else {
        tampilsnackbarnoktp(context, "NIK sudah digunakan");
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  void tampilsnackbar(BuildContext context, String message, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: warna,
        content: Text(
          message.toString(),
        ),
      ),
    );
  }

  void tampilsnackbarnoktp(BuildContext context, String tulisan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 2, 86),
        content: Text(tulisan),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ),
    );
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);

      // Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, compressQuality: 50);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

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
          // button back
          Positioned(
            left: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // kotak textfield
          SingleChildScrollView(
            child: Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height / 14,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  const Text(
                    "Registrasi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 10,
                      right: MediaQuery.of(context).size.width / 10,
                      top: MediaQuery.of(context).size.width / 20,
                    ),
                    // kotak transparant
                    child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(187, 236, 114, 206),
                          borderRadius: BorderRadius.circular(0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: ListView(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                // ignore: prefer_const_constructors
                                child: Align(
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "Nama Lengkap :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              // nama lengkap
                              // ignore: prefer_const_constructors

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 238, 27, 143),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  height: 30,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: TextField(
                                      controller: namaController,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                // ignore: prefer_const_constructors
                                child: Align(
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "No KTP :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              // no ktp
                              // ignore: prefer_const_constructors

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 238, 27, 143),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  height: 30,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: TextField(
                                      controller: noktpController,
                                      keyboardType: TextInputType.number,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                // ignore: prefer_const_constructors
                                child: Align(
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "Alamat :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              //  alamat
                              // ignore: prefer_const_constructors

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 238, 27, 143),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  height: 120,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: TextField(
                                      controller: alamatController,
                                      maxLines: 5,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini"),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                // ignore: prefer_const_constructors
                                child: Align(
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "Nomor Telpon/ Ponsel :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              // hp
                              // ignore: prefer_const_constructors

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 238, 27, 143),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  height: 30,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: TextField(
                                      controller: ponselController,
                                      keyboardType: TextInputType.phone,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini"),
                                    ),
                                  ),
                                ),
                              ),
                              // const Padding(
                              //   padding: EdgeInsets.only(left: 10),
                              //   // ignore: prefer_const_constructors
                              //   child: Align(
                              //     // ignore: sort_child_properties_last
                              //     child: Text(
                              //       "Email :",
                              //       style: TextStyle(
                              //           fontSize: 15,
                              //           color: Color.fromARGB(255, 255, 255, 255),
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     alignment: Alignment.centerLeft,
                              //   ),
                              // ),
                              // //  Email
                              // // ignore: prefer_const_constructors

                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         border: Border.all(
                              //           width: 2,
                              //           color: Color.fromARGB(255, 238, 27, 143),
                              //         ),
                              //         borderRadius: BorderRadius.circular(0),
                              //         color: Colors.white),
                              //     height: 30,
                              //     child: Padding(
                              //       padding: EdgeInsets.only(left: 10, top: 10),
                              //       child: TextField(
                              //         controller: emailController,
                              //         keyboardType: TextInputType.emailAddress,
                              //         // textCapitalization:
                              //         //     TextCapitalization.characters,
                              //         decoration: InputDecoration(
                              //             border: InputBorder.none,
                              //             hintText: "Boleh tidak di isi"),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                // ignore: prefer_const_constructors
                                child: Align(
                                  // ignore: sort_child_properties_last
                                  child: Text(
                                    "Password :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                              // password
                              // ignore: prefer_const_constructors

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 238, 27, 143),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.white),
                                  height: 30,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: lihat ? false : true,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini"),
                                    ),
                                  ),
                                ),
                              ),
                              // lihat password
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    // ignore: unnecessary_new
                                    new Checkbox(
                                        value: lihat,
                                        activeColor: Colors.pink,
                                        onChanged: (newvalue) {
                                          setState(() {
                                            if (lihat) {
                                              lihat = false;
                                            } else {
                                              lihat = true;
                                            }
                                          });
                                        }),
                                    Text(
                                      "Lihat Password",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              // button image
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // getImage(ImageSource.gallery);
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: Text("Upload Foto KTP"),
                                    style: ButtonStyle(),
                                  ),
                                ),
                              ),
                              // preview image
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: _image == null
                                      ? SizedBox()
                                      : Image.file(
                                          //to show image, you type like this.
                                          File(_image!.path),
                                          fit: BoxFit.cover,
                                          // width:
                                          //     MediaQuery.of(context).size.width,
                                          // height: 300,
                                        ),
                                ),
                              ),
                              // preview path
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: _image == null
                                    ? SizedBox()
                                    : Text(_image!.path.toString()),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: _image == null
                                    ? SizedBox()
                                    : Text(_image!
                                        .readAsBytesSync()
                                        .lengthInBytes
                                        .toString()),
                              ),
                              SizedBox(
                                height: 200,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        Registrasi();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.5,
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
                            borderRadius: BorderRadius.circular(0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Center(
                            child: Text(
                              "Registrasi",
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
          ),
        ],
      ),
    );
  }
}
