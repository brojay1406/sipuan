import 'package:flutter/material.dart';

class DetailBerita extends StatelessWidget {
  final isiberita;
  final judulberita;
  final image;
  final tanggalberita;
  DetailBerita(
      this.image, this.isiberita, this.judulberita, this.tanggalberita);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 143, 96, 100),
      appBar: AppBar(
        title: Text("Berita"),
        elevation: 0,
        backgroundColor: Color.fromARGB(0, 70, 8, 8),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromARGB(255, 255, 99, 151),
            Color.fromARGB(255, 250, 99, 255),
          ],
        )),
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(6.0),
                height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.all(6.0),
                // height: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        judulberita,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      tanggalberita.toDate().year.toString() +
                          "-" +
                          tanggalberita.toDate().month.toString() +
                          "-" +
                          tanggalberita.toDate().day.toString() +
                          " " +
                          tanggalberita.toDate().hour.toString() +
                          ":" +
                          tanggalberita.toDate().minute.toString(),
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(87, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    isiberita,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
