import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aris_ussd/aris/Screens/internet_screen.dart';
import 'package:aris_ussd/aris/Screens/Daqiqa.dart';
import 'package:aris_ussd/aris/Screens/SmsScreen.dart';
import 'package:aris_ussd/aris/Screens/balans_screen.dart';
import 'package:aris_ussd/aris/Screens/tariflar.dart';
import 'package:aris_ussd/aris/Screens/xizmatlar.dart';

class SingleBlock extends StatefulWidget {
  static List<String> jsonRoot = [
    'beeline/internet.json',
    'beeline/tarif.json',
    'beeline/daqiqa.json',
    'beeline/xizmatlar.json',
    'beeline/sms.json',
    'beeline/balans.json',
  ];

  @override
  _SingleBlockState createState() => _SingleBlockState();
}

class _SingleBlockState extends State<SingleBlock> {
  List<Tab> tabForInternet = [];
  List tabServiceForInternet = [];
  File file;

  Future<String> getJsonTarif() async {
    var dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/${SingleBlock.jsonRoot[1]}');
    String fileString = await file.readAsString();
    return fileString;
  }

  int len = 0;

  setLen() async {
    var myData = jsonDecode(await getJsonTarif());
    len = myData.length;
  }

  Future<String> getJson() async {
    var dir = await getApplicationDocumentsDirectory();
    file = File('${dir.path}/${SingleBlock.jsonRoot[0]}');
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
      // print(myData[k]['id']);
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
                      'assets/images/beeline/beelogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/beeline/bwidget.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InternetScreen(
                                  image: 'assets/images/beeline/beelogo.png',
                                  appBarColor1: Color(0xFFFF8008),
                                  appBarColor: Color(0xFFFFC837),
                                  textColor: Colors.black,
                                  borderColor: Colors.yellow,
                                  tabList: tabForInternet,
                                  tabServiceList: tabServiceForInternet,
                                  def: '*103#',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width - 24,
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/pack/net.png'),
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Internet paketlar',
                                    style: TextStyle(
                                      color: Colors.black,
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
              ),
              Flexible(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TarifScreen(
                              image: 'assets/images/beeline/beelogo.png',
                              borderColor: Colors.yellow,
                              appBarColor: Colors.yellow,
                              textColor: Colors.black,
                              len: len,
                              root: SingleBlock.jsonRoot[1],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TarifScreen(
                                    image: 'assets/images/beeline/beelogo.png',
                                    borderColor: Colors.yellow,
                                    appBarColor: Colors.yellow,
                                    textColor: Colors.black,
                                    len: len,
                                    root: SingleBlock.jsonRoot[1],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/beeline/bwidget.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 24,
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
                                        'assets/images/pack/plan.png'),
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Tariflar',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
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
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/beeline/bwidget.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaqiqaScreen(
                                image: 'assets/images/beeline/beelogo.png',
                                appBarColor1: Color(0xFFFF8008),
                                appBarColor: Color(0xFFFFC837),
                                textColor: Colors.black,
                                def: "*106#",
                                root: SingleBlock.jsonRoot[2],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 24,
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
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Daqiqa paketlar',
                                  style: TextStyle(
                                    color: Colors.black,
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
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/beeline/bwidget.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServicesScreen(
                                image: 'assets/images/beeline/beelogo.png',
                                borderColor: Colors.yellow,
                                appBarColor: Colors.yellow,
                                textColor: Colors.black,
                                root: SingleBlock.jsonRoot[3],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 24,
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
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Xizmatlar',
                                  style: TextStyle(
                                    color: Colors.black,
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
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/beeline/bwidget.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SmsScreen(
                                image: 'assets/images/beeline/beelogo.png',
                                appBarColor1: Color(0xFFFF8008),
                                appBarColor: Color(0xFFFFC837),
                                textColor: Colors.black,
                                def: "*107#",
                                root: SingleBlock.jsonRoot[4],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 24,
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
                                      AssetImage('assets/images/pack/sms.png'),
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'SMS paketlar',
                                  style: TextStyle(
                                    color: Colors.black,
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
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/beeline/bwidget.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BalansScreen(
                                  image: 'assets/images/beeline/beelogo.png',
                                  appBarColor: Colors.yellow,
                                  textColor: Colors.black,
                                  root: SingleBlock.jsonRoot[5],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 24,
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
                                    image: AssetImage(
                                        'assets/images/pack/ussd.png'),
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'Ussd kodlar va xizmatlar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
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
