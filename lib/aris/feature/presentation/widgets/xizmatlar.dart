import 'dart:convert';
import 'dart:io';
import 'package:aris_ussd/aris/feature/presentation/widgets/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ServicesScreen extends StatefulWidget {
  final Color appBarColor;
  final Color textColor;
  final Color borderColor;
  final String root;
  final String image;


  const ServicesScreen(
      {Key key, this.appBarColor, this.textColor, this.borderColor, this.root, this.image})
      : super(key: key);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'Xizmatlar',
          style: TextStyle(color: Colors.black, fontSize: 18,),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: AssetImage(widget.image))
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Center(
            child: FutureBuilder(
              future: getString(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
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
                            ]
                          // border: Border.all(width: 2,color: widget.appBarColor)
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Container(
                                child: Text(
                                  '${myData[index]['service_name']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Container(
                                child: Text(
                                  '${myData[index]['service_desc']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          var  wait = await HomePage.launchUssd('${myData[index]['service_on']}');
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 40,
                                          decoration: BoxDecoration(
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
                                            borderRadius: BorderRadius.circular(2),
                                            color: Colors.white
                                          ),
                                          child: Center(child: Text('Ulash',style: TextStyle(color: Colors.green,fontSize: 18),)),
                                        ),
                                      ),
                                    ),
                                    (myData[index]['service_edit'] != null)?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          var  wait = await HomePage.launchUssd('${myData[index]['service_edit']}');
                                        },
                                        child: Container(
                                          child: Text('O\'chirish',style: TextStyle(color: Colors.red,fontSize: 16),),
                                        ),
                                      ),
                                    ):Container(),
                                    (myData[index]['service_off'] != null)?Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0),
                                      child: GestureDetector(
                                        onTap: ()async{
                                          var  wait = await HomePage.launchUssd('${myData[index]['service_off']}');
                                        },
                                        child: Container(
                                          child: Text('Sozlash',style: TextStyle(color: Colors.orangeAccent,fontSize: 16),),
                                        ),
                                      ),
                                    ):Container(),
                                  ],
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
      ),
    );
  }
}
