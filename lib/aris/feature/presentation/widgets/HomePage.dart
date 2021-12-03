import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:aris_ussd/aris/feature/presentation/pages/Ucell.dart';
import 'package:aris_ussd/aris/feature/presentation/pages/beeline.dart';
import 'package:aris_ussd/aris/feature/presentation/pages/mobiuz.dart';
import 'package:aris_ussd/aris/feature/presentation/pages/uzmobile.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/ContactScreen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ussd/ussd.dart';

class HomePage extends StatefulWidget {
  static bool isFirst;
  static Future<void> launchUssd(String ussdCode) async {
    Ussd.runUssd(ussdCode);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  var imageUrl = "http://buum.uz/api/";
  bool downloading = true;
  String downloadingStr = "No data";
  double download = 0.0;
  File f;

  _write(String text, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    print(directory.path);
    await file.writeAsString(text);
  }

  Future downloadFile(String url, String path, String fileName) async {
    Dio dio = Dio();
    var dir = await getApplicationDocumentsDirectory();
    try {
      if (!HomePage.isFirst) {
        final bytes1 = File('${dir.path}/$fileName.md5').readAsBytesSync();
        var decoded1;
        decoded1 = utf8.decode(bytes1);
        var responseMD5 = await dio.download(
            "$imageUrl/$fileName.md5", '${dir.path}/$fileName.md5');
        final bytes2 = File('${dir.path}/$fileName.md5').readAsBytesSync();
        final decoded2 = utf8.decode(bytes2);
        if (decoded1 != decoded2) {
          print(decoded2);
          var response =
              await dio.download(url, '${dir.path}/$path').whenComplete(() {
            final bytes = File('${dir.path}/$path').readAsBytesSync();
            final archive = GZipDecoder().decodeBytes(bytes);
            final decoded = utf8.decode(archive);
            _write(decoded, fileName);
          });
          _write(decoded2, '$fileName.md5');
        }
      } else {
        var response =
            await dio.download(url, '${dir.path}/$path').whenComplete(() {
          final bytes = File('${dir.path}/$path').readAsBytesSync();
          final archive = GZipDecoder().decodeBytes(bytes);
          final decoded = utf8.decode(archive);

          _write(decoded, fileName);
        });
        var responseMD5 = await dio.download(
            "$imageUrl/$fileName.md5", '${dir.path}/$fileName.md5');
        final bytes2 = File('${dir.path}/$fileName.md5').readAsBytesSync();
        final decoded2 = utf8.decode(bytes2);
        _write(decoded2, '$fileName.md5');
      }
    } catch (e) {
      print(e);
    }
  }

  getInfo() async {
    // await checkPrefs();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await downloadFile(imageUrl + "beeline/tarif.json.gz", "beeline/tarif.gzip",
        "beeline/tarif.json");
    await downloadFile(imageUrl + "beeline/balans.json.gz",
        "beeline/balans.gzip", "beeline/balans.json");
    await downloadFile(imageUrl + "beeline/daqiqa.json.gz",
        "beeline/daqiqa.gzip", "beeline/daqiqa.json");
    await downloadFile(imageUrl + "beeline/internet.json.gz",
        "beeline/internet.gzip", "beeline/internet.json");
    await downloadFile(imageUrl + "beeline/sms.json.gz", "beeline/sms.gzip",
        "beeline/sms.json");
    await downloadFile(imageUrl + "beeline/xizmatlar.json.gz",
        "beeline/xizmatlar.gzip", "beeline/xizmatlar.json");

    await downloadFile(imageUrl + "ucell/tarif.json.gz", "ucell/tarif.gzip",
        "ucell/tarif.json");
    await downloadFile(imageUrl + "ucell/balans.json.gz", "ucell/balans.gzip",
        "ucell/balans.json");
    await downloadFile(imageUrl + "ucell/daqiqa.json.gz", "ucell/daqiqa.gzip",
        "ucell/daqiqa.json");
    await downloadFile(imageUrl + "ucell/internet.json.gz",
        "ucell/internet.gzip", "ucell/internet.json");
    await downloadFile(
        imageUrl + "ucell/sms.json.gz", "ucell/sms.gzip", "ucell/sms.json");
    await downloadFile(imageUrl + "ucell/xizmatlar.json.gz",
        "ucell/xizmatlar.gzip", "ucell/xizmatlar.json");

    await downloadFile(imageUrl + "mobiuz/tarif.json.gz", "mobiuz/tarif.gzip",
        "mobiuz/tarif.json");
    await downloadFile(imageUrl + "mobiuz/balans.json.gz", "mobiuz/balans.gzip",
        "mobiuz/balans.json");
    await downloadFile(imageUrl + "mobiuz/daqiqa.json.gz", "mobiuz/daqiqa.gzip",
        "mobiuz/daqiqa.json");
    await downloadFile(imageUrl + "mobiuz/internet.json.gz",
        "mobiuz/internet.gzip", "mobiuz/internet.json");
    await downloadFile(
        imageUrl + "mobiuz/sms.json.gz", "mobiuz/sms.gzip", "mobiuz/sms.json");
    await downloadFile(imageUrl + "mobiuz/xizmatlar.json.gz",
        "mobiuz/xizmatlar.gzip", "mobiuz/xizmatlar.json");

    await downloadFile(imageUrl + "uzmobile/tarif.json.gz",
        "uzmobile/tarif.gzip", "uzmobile/tarif.json");
    await downloadFile(imageUrl + "uzmobile/balans.json.gz",
        "uzmobile/balans.gzip", "uzmobile/balans.json");
    await downloadFile(imageUrl + "uzmobile/daqiqa.json.gz",
        "uzmobile/daqiqa.gzip", "uzmobile/daqiqa.json");
    await downloadFile(imageUrl + "uzmobile/internet.json.gz",
        "uzmobile/internet.gzip", "uzmobile/internet.json");
    await downloadFile(imageUrl + "uzmobile/sms.json.gz", "uzmobile/sms.gzip",
        "uzmobile/sms.json");
    await downloadFile(imageUrl + "uzmobile/xizmatlar.json.gz",
        "uzmobile/xizmatlar.gzip", "uzmobile/xizmatlar.json");
    if (HomePage.isFirst) {
      await prefs.setInt('isFirst', 1);
    }
    setState(() {
      downloading = false;
    });
  }

  int currentIndex = 0;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  List<String> imageRoutes = [
    "assets/images/uzmob/uzmob.png",
    "assets/images/ucell/ucell.jpg",
    "assets/images/beeline/beelogo.png",
    "assets/images/mobi/mobi.png",
    "assets/images/operator.png",
  ];
  List<String> titles = [
    'Uzmobile',
    'Ucell',
    'Beeline',
    'mobiuz',
    'Operator',
  ];

  List<Color> colors = [
    Colors.blue,
    Colors.deepPurple,
    Colors.yellow[900],
    Colors.red,
  ];

  List<Widget> screens = [
    UzmobScreen(),
    UcellScreen(),
    Beeline(),
    MobiUzScreen(),
    ContactScreen(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    getInfo();
    _pageController = PageController();
    super.initState();
  }

  PageController _pageController;
  int _counter = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.settings,
            color: colors[_currentIndex],
          ),
          title: Center(
            child: Text(
              titles[_currentIndex],
              style: TextStyle(
                color: colors[_currentIndex],
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notification_add,
                color: colors[_currentIndex],
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: (downloading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.expand(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: <Widget>[
                    UzmobScreen(),
                    UcellScreen(),
                    Beeline(),
                    MobiUzScreen(),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Uzmobile'),
              activeColor: colors[_currentIndex],
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Ucell'),
              activeColor: colors[_currentIndex],
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Beeline',
              ),
              activeColor: colors[_currentIndex],
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Mobi'),
              activeColor: colors[_currentIndex],
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
