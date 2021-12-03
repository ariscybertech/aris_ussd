import 'dart:convert';
import 'dart:io';

import 'package:aris_ussd/aris/feature/presentation/widgets/Daqiqa.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/SmsScreen.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/balans_screen.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/internet_screen.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/tariflar.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/xizmatlar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class UcellScreen extends StatefulWidget {
  static List<String> jsonRoot = [
    'ucell/internet.json',
    'ucell/tarif.json',
    'ucell/daqiqa.json',
    'ucell/xizmatlar.json',
    'ucell/sms.json',
    'ucell/balans.json',
  ];
  @override
  _UcellScreenState createState() => _UcellScreenState();
}

class _UcellScreenState extends State<UcellScreen> {
  List<Tab> tabForInternet = [];
  List tabServiceForInternet = [];

  File file;


  Future<String> getJsonTarif() async{
    var dir=await getApplicationDocumentsDirectory();
    file = File('${dir.path}/${UcellScreen.jsonRoot[1]}');
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
    file = File('${dir.path}/${UcellScreen.jsonRoot[0]}');
    String fileString = await file.readAsString();
    return fileString;
  }

  getServiceList() async {
    var myData = jsonDecode(await getJson());
    for (int j = 0; j < myData.length; j++) {
      tabServiceForInternet.add(myData[j]['service_list']);
    }
    var myServiceList = myData[0]['service_list'];
    print(myServiceList[0]);
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
                      'assets/images/ucell/ucell.jpg',
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
                          color: Colors.white
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InternetScreen(
                                image: 'assets/images/ucell/ucell.jpg',

                                appBarColor1: Color(0xFF8E54E9),
                                appBarColor: Color(0xFF4776E6),
                                textColor: Colors.white,
                                borderColor: Colors.deepPurple,
                                tabList: tabForInternet,
                                tabServiceList: tabServiceForInternet,
                                def: '*103#',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-24,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image: AssetImage('assets/images/pack/net.png'),
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Internet paketlar',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
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
                            builder: (context) => BalansScreen(
                              image: 'assets/images/ucell/ucell.jpg',

                              appBarColor: Colors.deepPurple,
                              textColor: Colors.black,
                              root: UcellScreen.jsonRoot[5],
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
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap:() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TarifScreen(
                                    image: 'assets/images/ucell/ucell.jpg',

                                    borderColor: Colors.deepPurple,
                                    appBarColor: Colors.deepPurple,
                                    textColor: Colors.white,
                                    len: len,
                                    root: UcellScreen.jsonRoot[1],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width-24,
                              height: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    child: Image(
                                      image: AssetImage('assets/images/pack/plan.png'),
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Tariflar',
                                      style: TextStyle(
                                        color: Colors.deepPurple,
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
                    )
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
                          color: Colors.white
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaqiqaScreen(
                                image: 'assets/images/ucell/ucell.jpg',

                                appBarColor1: Color(0xFF8E54E9),
                                appBarColor: Color(0xFF4776E6),
                                textColor: Colors.white,
                                def: "*106#",
                                root: UcellScreen.jsonRoot[2],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-24,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image: AssetImage('assets/images/pack/call.png'),
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Daqiqa paketlar',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
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
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServicesScreen(
                                image: 'assets/images/ucell/ucell.jpg',

                                borderColor: Colors.deepPurple,
                                appBarColor: Colors.deepPurple,
                                textColor: Colors.black,
                                root: UcellScreen.jsonRoot[3],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-24,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image: AssetImage('assets/images/pack/news.png'),
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'Xizmatlar',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
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
                          color: Colors.white
                        ),
                        height: 130,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SmsScreen(
                                image: 'assets/images/ucell/ucell.jpg',

                                appBarColor1: Color(0xFF8E54E9),
                                appBarColor: Color(0xFF4776E6),
                                textColor: Colors.white,
                                def: "*107#",
                                root: UcellScreen.jsonRoot[4],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-24,
                          height: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Image(
                                  image: AssetImage('assets/images/pack/sms.png'),
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Container(
                                child: Text(
                                  'SMS paketlar',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
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
                            color: Colors.white
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BalansScreen(
                                  image: 'assets/images/ucell/ucell.jpg',

                                  appBarColor: Colors.deepPurple,
                                  textColor: Colors.black,
                                  root: UcellScreen.jsonRoot[5],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width-24,
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: Image(
                                    image: AssetImage('assets/images/pack/ussd.png'),
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'Ussd kodlar va xizmatlar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.deepPurple,
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
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
