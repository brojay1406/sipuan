import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipuan_app/screen/homepage.dart';

import '../model/icon_menu.dart';
import '../model/model.dart';
import 'launcher.dart';
import 'loadingprofilpage.dart';

class ProfilPage extends StatefulWidget {
  UserModel user;
  ProfilPage(this.user, {super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController namaController = TextEditingController();
  TextEditingController noktpController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController ponselController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  int nomor = 0;
  File? _image;
  String varname = "";
  String varalamat = "";
  String varponsel = "";
  String varimage = "";
  // String namevar = widget.user.name;
  UploadTask? uploadTask;
  bool pilnama = false;
  bool pilktp = false;
  bool pilalamat = false;
  bool pilhp = false;
  bool pilfoto = false;
  Future updateprofil() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      print("hasil");

      if (_image != null) {
        final namalengkap = namaController.text.toString();
        final ktp = noktpController.text.toString();
        final nama_foto = "fotoktp/$namalengkap$ktp edit.jpg";
        final file_foto = File(_image!.path);
        final upload_foto = FirebaseStorage.instance.ref().child(nama_foto);
        uploadTask = upload_foto.putFile(file_foto);
        final snapshot = await uploadTask!.whenComplete(() {});
        final link_foto = await snapshot.ref.getDownloadURL();
        varimage = link_foto;
        print(link_foto);
        await db.collection("users").doc(widget.user.uid).update({
          "image": link_foto,
          "alamat": varalamat,
          "name": varname,
          "ponsel": varponsel
        });
      } else {
        await db.collection("users").doc(widget.user.uid).update(
            {"alamat": varalamat, "name": varname, "ponsel": varponsel});
      }

      setState(() {
        widget.user.name = varname;
        widget.user.ponsel = varponsel;
        widget.user.alamat = varalamat;
        if (_image != null) {
          widget.user.image = varimage;
        }
      });
    } on FirebaseAuthException catch (e) {
      tampilsnackbar(context, e.message.toString());
    }
  }

  void tampilsnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 255, 2, 86),
        content: Text(
          message.toString(),
        ),
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
        pilfoto = true;
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

  void initState() {
    super.initState();
    varname = widget.user.name;
    varalamat = widget.user.alamat;
    varponsel = widget.user.ponsel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage(widget.user)),
                (Route<dynamic> route) => false);
          },
        ),
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
        // button back
        // kotak tulisan
        SingleChildScrollView(
          child: Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.of(context).size.height / 14,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 8,
                ),
                Text(
                  "PROFIL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
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
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(236, 114, 206, 0.733),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _image == null
                              ? widget.user.image == null ||
                                      widget.user.image == ""
                                  ? Text("Foto Ktp")
                                  : Image.network(
                                      widget.user.image,
                                      fit: BoxFit.cover,
                                      // height: MediaQuery.of(context).size.height / 4,
                                    )
                              : Image.file(
                                  //to show image, you type like this.
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                  // width:
                                  //     MediaQuery.of(context).size.width,
                                  // height: 300,
                                ),
                        ),
                        Positioned(
                          child: InkWell(
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              width: 90,
                              // height: 90,
                              child: Icon(
                                Icons.camera,
                                size: 40,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                          bottom: 0,
                          right: -20,
                        ),
                      ],
                    ),
                  ),
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
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(187, 236, 114, 206),
                        borderRadius: BorderRadius.circular(0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: ListView(
                          padding: EdgeInsets.zero,
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
                                      color: Color.fromARGB(255, 255, 255, 255),
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
                                      color: Color.fromARGB(255, 238, 27, 143),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white),
                                height: 30,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: TextField(
                                        controller: namaController
                                          ..text = varname,
                                        onChanged: (value) {
                                          varname = namaController.text;
                                        },
                                        readOnly: pilnama ? false : true,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini",
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      bottom: -10,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (pilnama) {
                                              pilnama = false;
                                            } else {
                                              pilnama = true;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: pilnama
                                              ? Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : Color.fromARGB(255, 45, 7, 255),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      color: Color.fromARGB(255, 255, 255, 255),
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
                                      color: Color.fromARGB(255, 238, 27, 143),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white),
                                height: 30,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: TextField(
                                        controller: noktpController
                                          ..text = widget.user.noktp,
                                        readOnly: pilktp ? false : true,
                                        keyboardType: TextInputType.number,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Ketik disini"),
                                      ),
                                    ),
                                  ],
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
                                      color: Color.fromARGB(255, 255, 255, 255),
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
                                      color: Color.fromARGB(255, 238, 27, 143),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white),
                                // height: 120,
                                child: Stack(
                                  children: [
                                    TextField(
                                      controller: alamatController
                                        ..text = varalamat,
                                      readOnly: pilalamat ? false : true,
                                      // maxLines: 3,
                                      textCapitalization:
                                          TextCapitalization.characters,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Ketik disini"),
                                    ),
                                    Positioned(
                                      right: 5,
                                      bottom: -1,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (pilalamat) {
                                              pilalamat = false;
                                            } else {
                                              pilalamat = true;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 30,
                                          color: pilalamat
                                              ? Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : Color.fromARGB(255, 45, 7, 255),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      color: Color.fromARGB(255, 255, 255, 255),
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
                                      color: Color.fromARGB(255, 238, 27, 143),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                    color: Colors.white),
                                height: 30,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      child: TextField(
                                        controller: ponselController
                                          ..text = varponsel,
                                        readOnly: pilhp ? false : true,
                                        keyboardType: TextInputType.phone,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Ketik disini"),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      bottom: -10,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (pilhp) {
                                              pilhp = false;
                                            } else {
                                              pilhp = true;
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: pilhp
                                              ? Color.fromARGB(
                                                  255, 255, 255, 255)
                                              : Color.fromARGB(255, 45, 7, 255),
                                        ),
                                      ),
                                    ),
                                  ],
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
                            //         borderRadius: BorderRadius.circular(20),
                            //         color: Colors.white),
                            //     height: 30,
                            //     child: Padding(
                            //       padding: EdgeInsets.only(left: 10, top: 10),
                            //       child: TextField(
                            //         controller: emailController
                            //           ..text = widget.user.email,
                            //         readOnly: true,
                            //         keyboardType: TextInputType.emailAddress,
                            //         // textCapitalization:
                            //         //     TextCapitalization.characters,
                            //         decoration: InputDecoration(
                            //             border: InputBorder.none,
                            //             hintText: "Ketik disini"),
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            // password
                            // ignore: prefer_const_constructors

                            // lihat password

                            // preview image
                            if (pilnama == true ||
                                pilktp == true ||
                                pilalamat == true ||
                                pilhp == true ||
                                pilfoto) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
                                    onSurface: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () async {
                                    updateprofil();
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
                                            Color.fromARGB(255, 67, 121, 223),
                                            Color.fromARGB(255, 240, 122, 157),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Center(
                                        child: Text(
                                          "simpan",
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
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
