import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aris_ussd/aris/Screens/Daqiqa.dart';
import 'package:aris_ussd/aris/Screens/SmsScreen.dart';
import 'package:aris_ussd/aris/Screens/balans_screen.dart';
import 'package:aris_ussd/aris/Screens/internet_screen.dart';
import 'package:aris_ussd/aris/Screens/tariflar.dart';
import 'package:aris_ussd/aris/Screens/xizmatlar.dart';

class MobiUzScreen extends StatefulWidget {
  static List<String> jsonRoot = [
    'mobiuz/internet.json',
    'mobiuz/tarif.json',
    'mobiuz/daqiqa.json',
    'mobiuz/xizmatlar.json',
    'mobiuz/sms.json',
    'mobiuz/balans.json',
  ];

  @override
  _MobiUzScreenState createState() => _MobiUzScreenState();
}

class _MobiUzScreenState extends State<MobiUzScreen> {
  List<Tab> tabForInternet = [];
  List tabServiceForInternet = [];

  File file;


  Future<String> getJsonTarif() async{
    var dir=await getApplicationDocumentsDirectory();
    file = File('${dir.path}/${MobiUzScreen.jsonRoot[1]}');
    String fileString = await file.readAsString();
    return fileString;
  }


  int len = 0;

  setLen() async {
    var myData = jsonDecode(await getJsonTarif());
    len = myData.length;
  }

  Future<String> getJson() async{
    var dir=await getApplicationDocumentsDirectory();
    file = File('${dir.path}/${MobiUzScreen.jsonRoot[0]}');
    String fileString = await file.readAsString();
    return fileString;
  }

  getServiceList() async {
    var myData = jsonDecode(await getJson());
    for (int j = 0; j < myData.length; j++) {
      tabServiceForInternet.add(myData[j]['service_list']);
    }
    var myServiceList = myData[0]['service_list'];
  }

  getJsonFunc() async {
    var myData = jsonDecode(await getJson());
    for (int k = 0; k < myData.length; k++) {
      tabForInternet.add(Tab(
        child: Container(
          height: 40,
          child: Text('${myData[k]['id']}'),
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    getJsonFunc();
    getServiceList();
    setLen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Card(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/mobi/mobi.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xFFe43a15), Color(0xFFe65245),],),
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InternetScreen(
                                    image: 'assets/images/mobi/mobi.png',
                                    appBarColor: Color(0xFFe43a15),
                                    appBarColor1: Color(0xFFe65245),
                                    textColor: Colors.black,
                                    borderColor: Colors.red,
                                    tabList: tabForInternet,
                                    tabServiceList: tabServiceForInternet,
                                    def: '*103#',
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 24,
                          height: 130,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image:
                                  AssetImage('assets/images/pack/net.png'),
                                  color: Colors.red,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Internet paketlar',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TarifScreen(
                                  image: 'assets/images/mobi/mobi.png',
                                  borderColor: Colors.red,
                                  appBarColor: Colors.red,
                                  textColor: Colors.black,
                                  len: len,
                                  root: MobiUzScreen.jsonRoot[1],
                                ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.red,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TarifScreen(
                                        image: 'assets/images/mobi/mobi.png',
                                        borderColor: Colors.red,
                                        appBarColor: Colors.red,
                                        textColor: Colors.black,
                                        len: len,
                                        root: MobiUzScreen.jsonRoot[1],
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 24,
                              height: 130,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    child: Image(
                                      image:
                                      AssetImage('assets/images/pack/plan.png'),
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Tariflar',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DaqiqaScreen(
                                    image: 'assets/images/mobi/mobi.png',
                                    appBarColor1: Color(0xFFe65245),
                                    appBarColor: Color(0xFFe43a15),
                                    textColor: Colors.black,
                                    def: "*106#",
                                    root: MobiUzScreen.jsonRoot[2],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 24,
                          height: 130,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image:
                                  AssetImage('assets/images/pack/call.png'),
                                  color: Colors.red,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Daqiqa paketlar',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ServicesScreen(
                                    image: 'assets/images/mobi/mobi.png',
                                    borderColor: Colors.red,
                                    appBarColor: Colors.red,
                                    textColor: Colors.black,
                                    root: MobiUzScreen.jsonRoot[3],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 24,
                          height: 130,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image:
                                  AssetImage('assets/images/pack/news.png'),
                                  color: Colors.red,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Xizmatlar',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SmsScreen(
                                    image: 'assets/images/mobi/mobi.png',
                                    appBarColor1: Color(0xFFe65245),
                                    appBarColor: Color(0xFFe43a15),
                                    textColor: Colors.black,
                                    def: "*107#",
                                    root: MobiUzScreen.jsonRoot[4],
                                  ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 24,
                          height: 130,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/pack/sms.png'),
                                  color: Colors.red,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'SMS paketlar',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.red,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BalansScreen(
                                      image: 'assets/images/mobi/mobi.png',
                                      appBarColor: Colors.red,
                                      textColor: Colors.black,
                                      root: MobiUzScreen.jsonRoot[5],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 24,
                            height: 130,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: Image(
                                    image:
                                    AssetImage('assets/images/pack/ussd.png'),
                                    color: Colors.red,
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'Ussd kodlar va xizmatlar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
