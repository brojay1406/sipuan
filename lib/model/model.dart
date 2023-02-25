import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String alamat;
  String email;
  String name;
  String image;
  String noktp;
  String ponsel;
  Timestamp date_register;
  String uid;
  String verif;

  UserModel(
      {required this.email,
      required this.name,
      required this.image,
      required this.date_register,
      required this.uid,
      required this.alamat,
      required this.noktp,
      required this.ponsel,
      required this.verif});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        alamat: snapshot['alamat'],
        email: snapshot['email'],
        name: snapshot['name'],
        image: snapshot['image'],
        noktp: snapshot['noktp'],
        ponsel: snapshot['ponsel'],
        date_register: snapshot['date_register'],
        uid: snapshot['uid'],
        verif: snapshot['verif']);
  }
}

class UserModellogin {
  String alamat;
  String email;
  String name;
  String image;
  String noktp;
  String ponsel;
  Timestamp date_register;
  String uid;
  String verif;

  UserModellogin(
      {required this.email,
      required this.name,
      required this.image,
      required this.date_register,
      required this.uid,
      required this.alamat,
      required this.noktp,
      required this.ponsel,
      required this.verif});

  factory UserModellogin.fromJson(DocumentSnapshot snapshot) {
    return UserModellogin(
        alamat: snapshot['alamat'],
        email: snapshot['email'],
        name: snapshot['name'],
        image: snapshot['image'],
        noktp: snapshot['noktp'],
        ponsel: snapshot['ponsel'],
        date_register: snapshot['date_register'],
        uid: snapshot['uid'],
        verif: snapshot['verif']);
  }
}
