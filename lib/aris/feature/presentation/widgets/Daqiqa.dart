import 'dart:convert';
import 'dart:io';

import 'package:aris_ussd/aris/feature/presentation/widgets/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class DaqiqaScreen extends StatefulWidget {
  final Color appBarColor;
  final Color appBarColor1;
  final Color textColor;
  final String def;
  final String root;
  final String image;

  const DaqiqaScreen({
    Key key,
    this.appBarColor,
    this.textColor,
    this.def,
    this.root,
    this.appBarColor1,
    this.image,
  }) : super(key: key);

  @override
  _DaqiqaScreenState createState() => _DaqiqaScreenState();
}

class _DaqiqaScreenState extends State<DaqiqaScreen> {
  var myData;
  File file;

  Future<String> getString() async{
    var dir=await getApplicationDocumentsDirectory();
    file = File('${dir.path}/${widget.root}');
    String fileString = await file.readAsString();
    myData = jsonDecode(fileString);
    return fileString;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Daqiqa',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: AssetImage(widget.image))),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () async {
                    var wait = await HomePage.launchUssd(widget.def);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [widget.appBarColor, widget.appBarColor1]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ),
                        ]),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'QOLDIQNI TEKSHIRISH',
                        style: TextStyle(color: widget.textColor, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future:
                        getString(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 2, color: Colors.black12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: const Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${myData[index]['service_name']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${myData[index]['service_price']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(
                                        '${myData[index]['service_desc']}',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        var wait = await HomePage.launchUssd(
                                            myData[index]['service_code']);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: const Offset(
                                                5.0,
                                                5.0,
                                              ),
                                              blurRadius: 10.0,
                                              spreadRadius: 2.0,
                                            ), //BoxShadow
                                            BoxShadow(
                                              color: Colors.white,
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ),
                                          ],
                                          color: Colors.green,
                                        ),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                '${myData[index]['service_code']}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.share,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                Share.share(
                                                    '${myData[index]['service_name']} ${myData[index]['service_code']}');
                                              },
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: myData == null ? 0 : myData.length,
                      );
                    },
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
