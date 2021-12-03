import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/balans.dart';

class BalansScreen extends StatefulWidget {
  final Color appBarColor;
  final Color textColor;
  final String root;
  final String image;

  const BalansScreen({
    Key key,
    this.appBarColor,
    this.textColor,
    this.root,
    this.image,
  }) : super(key: key);

  @override
  _BalansScreenState createState() => _BalansScreenState();
}

class _BalansScreenState extends State<BalansScreen> {
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
  void initState() {
    super.initState();
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
          'Balans',
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
                  image: DecorationImage(
                      image: AssetImage(widget.image), fit: BoxFit.cover)),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: getString(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return BalansWidget(
                    title: myData[index]['service_name'],
                    color: widget.appBarColor,
                    colorText: widget.textColor,
                    code: myData[index]['service_code'],
                  );
                },
                itemCount: myData == null ? 0 : myData.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
