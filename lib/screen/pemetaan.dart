import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:sipuan_app/screen/loadingprofilpage.dart';
import 'package:sipuan_app/screen/profilpage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/icon_menu.dart';
import 'launcher.dart';
import 'loginpage.dart';

class PemetaanPage extends StatefulWidget {
  const PemetaanPage({super.key});

  @override
  State<PemetaanPage> createState() => _PemetaanPageState();
}

class _PemetaanPageState extends State<PemetaanPage> {
  TextEditingController kasuscontroller = TextEditingController();
  TextEditingController namaklienController = TextEditingController();

  String? _valtahunt;
  int? jpelecehan;
  int? jpencurian;
  int? jkenakalan;
  int? jperesetubuhan;
  int? jlakalantas;
  int? jkdrt;
  int? jnarkoba;
  int? jkekerasanthdanak;
  int? jhakasuh;
  int? jpenganiayaan;
  int? jlainnya;
  List _listtahunt = [
    '2023',
    '2022',
    '2020',
    '2019',
    '2018',
    '2017',
  ];
  List _listkasus = [
    "Pelecehan",
    "Pencurian",
    "Kenakalan Anak",
    "Persetubuhan",
    "Lakalantas",
    "KDRT",
    "Narkoba",
    "Kekerasan Terhadap Anak",
    "Hak Asuh Anak",
    "Penganiayaan",
    "Lainnya"
  ];
  late TooltipBehavior _tooltipBehavior;
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  String? penananganan;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String tahun = "";
  var nomor = 0;
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
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                const Center(
                  child: Text(
                    "PEMETAAN",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.height / 1.7,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(166, 238, 134, 212),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Tahun"),
                              DropdownButton(
                                hint: Text("Tahun"),
                                value: _valtahunt,
                                items: _listtahunt.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _valtahunt = value as String?;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: getdata(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return Container(
                                  child: SfCircularChart(
                                // Enables the tooltip for all the series in chart
                                tooltipBehavior: _tooltipBehavior,
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.left,
                                  toggleSeriesVisibility: true,
                                  orientation: LegendItemOrientation.auto,
                                  // shouldAlwaysShowScrollbar: true,
                                ),

                                series: [
                                  PieSeries<ChartData, String>(
                                      enableTooltip: true,
                                      explode: true,
                                      // explodeAll: true,
                                      // groupMode: CircularChartGroupMode.value,
                                      dataSource: [
                                        for (int i = 0;
                                            i < _listkasus.length;
                                            i++) ...[
                                          if (i == 0) ...[
                                            ChartData(
                                                _listkasus[i], jpelecehan!)
                                          ] else if (i == 1) ...[
                                            ChartData(
                                                _listkasus[i], jpencurian!)
                                          ] else if (i == 2) ...[
                                            ChartData(
                                                _listkasus[i], jkenakalan!)
                                          ] else if (i == 3) ...[
                                            ChartData(
                                                _listkasus[i], jperesetubuhan!)
                                          ] else if (i == 4) ...[
                                            ChartData(
                                                _listkasus[i], jlakalantas!)
                                          ] else if (i == 5) ...[
                                            ChartData(_listkasus[i], jkdrt!)
                                          ] else if (i == 6) ...[
                                            ChartData(_listkasus[i], jnarkoba!)
                                          ] else if (i == 7) ...[
                                            ChartData(_listkasus[i],
                                                jkekerasanthdanak!)
                                          ] else if (i == 8) ...[
                                            ChartData(_listkasus[i], jhakasuh!)
                                          ] else if (i == 9) ...[
                                            ChartData(
                                                _listkasus[i], jpenganiayaan!)
                                          ] else if (i == 10) ...[
                                            ChartData(_listkasus[i], jlainnya!)
                                          ]
                                        ]
                                      ],
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        showCumulativeValues: true,
                                        showZeroValue: false,
                                      )),
                                ],
                              ));
                            }
                          },
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

  Future getdata() async {
    // AggregateQuerySnapshot qpelecehan = await db
    //     .collection("pemetaan")
    //     .where("kasus", isEqualTo: "Pelecehan")
    //     .count()
    //     .get();
    // jpelecehan = qpelecehan.count;
    print(jpelecehan);
    for (int i = 0; i < _listkasus.length; i++) {
      print(_listkasus[i]);
      AggregateQuerySnapshot qpelecehan;
      if (_valtahunt == null) {
        qpelecehan = await db
            .collection("pemetaan")
            .where("kasus", isEqualTo: _listkasus[i])
            .count()
            .get();
        print("qpelecehan = ${qpelecehan.count}");
      } else {
        qpelecehan = await db
            .collection("pemetaan")
            .where("tahun", isEqualTo: _valtahunt!)
            .where("kasus", isEqualTo: _listkasus[i])
            .count()
            .get();
        print("qpelecehan = ${qpelecehan.count}");
      }

      // _jkasus[i] = qpelecehan.count;
      if (i == 0) {
        jpelecehan = qpelecehan.count;
        print("jpelecehan = " + jpelecehan.toString());
      } else if (i == 1) {
        jpencurian = qpelecehan.count;
      } else if (i == 2) {
        jkenakalan = qpelecehan.count;
      } else if (i == 3) {
        jperesetubuhan = qpelecehan.count;
      } else if (i == 4) {
        jlakalantas = qpelecehan.count;
      } else if (i == 5) {
        jkdrt = qpelecehan.count;
      } else if (i == 6) {
        jnarkoba = qpelecehan.count;
      } else if (i == 7) {
        jkekerasanthdanak = qpelecehan.count;
      } else if (i == 8) {
        jhakasuh = qpelecehan.count;
      } else if (i == 9) {
        jpenganiayaan = qpelecehan.count;
      } else if (i == 10) {
        jlainnya = qpelecehan.count;
      }
    }
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
    // this.color
  );
  final String x;
  final int y;
  // final Color color;
}
