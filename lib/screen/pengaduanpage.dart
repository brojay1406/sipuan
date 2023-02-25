import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../model/icon_menu.dart';
import '../model/model.dart';
import 'launcher.dart';
import 'loadingprofilpage.dart';

class PengaduanPage extends StatefulWidget {
  final UserModel currentUser;
  // final String friendId;
  // final String friendName;
  // final String friendImage;
  PengaduanPage({
    required this.currentUser,
    // required this.friendId,
    // required this.friendName,
    // required this.friendImage,
  });
  var nomor = 0;

  @override
  State<PengaduanPage> createState() => _PengaduanPageState();
}

class _PengaduanPageState extends State<PengaduanPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController namacontroller = TextEditingController();
  TextEditingController emailcontrolle = TextEditingController();
  TextEditingController hpcontroller = TextEditingController();
  TextEditingController pengaduancontroller = TextEditingController();
  File? _image;
  var nama = "";
  var ponsel = "";

  UploadTask? uploadTask;
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

  Future _Pengaduan() async {
    try {
      final userid = widget.currentUser.uid;
      final waktu = DateTime.now();
      var menit = waktu.microsecond;

      final nama_pengaduan = namacontroller.text;
      final idpengaduan = userid + waktu.toString();
      var link_foto = "";

      if (_image != null) {
        final nama_foto = "pengaduan/$userid$nama_pengaduan.jpg";
        final file_foto = File(_image!.path);
        final upload_foto = FirebaseStorage.instance.ref().child(nama_foto);
        uploadTask = upload_foto.putFile(file_foto);
        final snapshot = await uploadTask!.whenComplete(() {});
        link_foto = await snapshot.ref.getDownloadURL();
      }
      await db.collection("pengaduan").doc(idpengaduan).set({
        'nama': namacontroller.text,
        'hp': hpcontroller.text,
        'email': "",
        'id_pengaduan': idpengaduan,
        'waktupengaduan': DateTime.now(),
        'pengaduan': pengaduancontroller.text,
        'image': link_foto,
      });
      tampilsnackbar(context, "pengaduan Berhasil dikirim", 2);
      pengaduancontroller.text = '';
    } on FirebaseAuthException catch (e) {
      tampilsnackbar(context, e.message.toString(), 1);
      Navigator.of(context).pop();
    }
  }

  void tampilsnackbar(BuildContext context, String message, int angka) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: angka == 2 ? Colors.green : Colors.red,
        content: Text(
          message.toString(),
        ),
      ),
    );
  }

  void tampilsnackbarnoktp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 2, 86),
        content: Text("NIK sudah digunakan"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20),
      ),
    );
  }

  void initState() {
    super.initState();
    nama = widget.currentUser.name;
    ponsel = widget.currentUser.ponsel;
  }

  var nomor;
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => loadingpageProfl()),
                    (Route<dynamic> route) => false);
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
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 1,
            // width: MediaQuery.of(context).size.width / 1,
            child: ListView(
              children: [
                const Center(
                  child: Text(
                    "PENGADUAN",
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 00,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          // ignore: prefer_const_constructors
                          child: Align(
                            // ignore: sort_child_properties_last
                            child: Text(
                              "Nama Lengkap :",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 238, 27, 143),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.white),
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: TextField(
                                controller: namacontroller..text = nama,
                                onChanged: (value) {
                                  nama = namacontroller.text;
                                },
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ketik disini"),
                              ),
                            ),
                          ),
                        ),
                        // email
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
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         border: Border.all(
                        //           width: 2,
                        //           color: Color.fromARGB(255, 238, 27, 143),
                        //         ),
                        //         borderRadius: BorderRadius.circular(5),
                        //         color: Colors.white),
                        //     height: 40,
                        //     child: Padding(
                        //       padding: EdgeInsets.only(left: 10, top: 10),
                        //       child: TextField(
                        //         controller: emailcontrolle
                        //           ..text = widget.currentUser.email,
                        //         textCapitalization:
                        //             TextCapitalization.characters,
                        //         decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintText: "Ketik disini"),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // // nomor hp
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          // ignore: prefer_const_constructors
                          child: Align(
                            // ignore: sort_child_properties_last
                            child: Text(
                              "Nomor yang bisa dihubungi :",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 238, 27, 143),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.white),
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: TextField(
                                controller: hpcontroller..text = ponsel,
                                onChanged: (value) {
                                  ponsel = hpcontroller.text;
                                },
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ketik disini"),
                              ),
                            ),
                          ),
                        ),
                        //pengaduan
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          // ignore: prefer_const_constructors
                          child: Align(
                            // ignore: sort_child_properties_last
                            child: Text(
                              "Pengaduan :",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(255, 238, 27, 143),
                                ),
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.white),
                            // height: 40,
                            // height: 150,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              child: TextField(
                                maxLines: 10,
                                minLines: 5,
                                controller: pengaduancontroller,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Ketik disini"),
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
                                  _pickImage(ImageSource.gallery);
                                },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        // Where the linear gradient begins and ends
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        // tileMode: TileMode.clamp,
                                        colors: [
                                          Color.fromARGB(255, 126, 171, 255),
                                          Color.fromARGB(255, 241, 0, 201),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Center(
                                      child: Text(
                                        "Sertakan Foto",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent,
                                  onSurface: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ),
                                onPressed: () async {
                                  _Pengaduan();
                                },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        // Where the linear gradient begins and ends
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        // tileMode: TileMode.clamp,
                                        colors: [
                                          Color.fromARGB(255, 126, 171, 255),
                                          Color.fromARGB(255, 241, 0, 201),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Center(
                                    child: Text(
                                      "Kirim Pengaduan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 25),
                                    ),
                                  ),
                                ))),
                        // preview image
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
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
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        // button back
      ]),
    );
  }
}
