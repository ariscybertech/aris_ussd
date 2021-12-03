import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dio/dio.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aris_ussd/aris/Screens/ContactScreen.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/uzmobile.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/Settings.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/beeline.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/Ucell.dart';
import 'package:aris_ussd/aris/feature/presentation/widgets/mobiuz.dart';
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
  List<Widget> screens = [
    UzmobScreen(),
    UcellScreen(),
    SingleBlock(),
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
      backgroundColor: Colors.grey[200],
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              UzmobScreen(),
              UcellScreen(),
              SingleBlock(),
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
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Ucell'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Beeline',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Mobi'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ));

    // return Scaffold(
    //   body: (downloading)
    //       ? Center(
    //           child: CircularProgressIndicator(),
    //         )
    //       : Stack(
    //           children: [
    //             DefaultTabController(
    //                 length: 4,
    //                 child: NestedScrollView(
    //                     headerSliverBuilder:
    //                         (BuildContext context, bool innerBoxIsScrolled) {
    //                       return <Widget>[
    //                         SliverAppBar(
    //                           actions: [
    //                             IconButton(
    //                               icon: Icon(
    //                                 Icons.share,
    //                                 color: Colors.black,
    //                                 size: 30,
    //                               ),
    //                               onPressed: () {
    //                                 if (Platform.isAndroid) {
    //                                   Share.share(
    //                                       'https://play.google.com/store/apps/details?id=com.mirkhujaev.usd_app');
    //                                 } else {
    //                                   Share.share(
    //                                       'https://apps.apple.com/uz/app/ussd-mobile-%D1%83%D0%B7%D0%B1%D0%B5%D0%BA%D0%B8%D1%81%D1%82%D0%B0%D0%BD/id1563621143');
    //                                 }
    //                               },
    //                             ),
    //                           ],
    //                           backgroundColor: Colors.white,
    //                           expandedHeight: 200.0,
    //                           floating: false,
    //                           pinned: true,
    //                           flexibleSpace: FlexibleSpaceBar(
    //                             titlePadding: EdgeInsets.only(top: 20),
    //                             centerTitle: true,
    //                             title: Container(
    //                               width: MediaQuery.of(context).size.width,
    //                               height: 30,
    //                               color: Colors.white54,
    //                               child: Center(
    //                                 child: Text('${titles[currentIndex]}',
    //                                     style: TextStyle(
    //                                       color: Colors.black,
    //                                       fontSize: 20.0,
    //                                       fontWeight: FontWeight.bold,
    //                                     )),
    //                               ),
    //                             ),
    //                             background: Container(
    //                                 height: 100,
    //                                 child: Image(
    //                                   colorBlendMode: BlendMode.color,
    //                                   image: AssetImage(
    //                                       '${imageRoutes[currentIndex]}'),
    //                                   fit: BoxFit.cover,
    //                                 )),
    //                           ),
    //                         ),
    //                         new SliverPadding(
    //                           padding: new EdgeInsets.all(16.0),
    //                           sliver: new SliverList(
    //                             delegate: new SliverChildListDelegate([
    //                               Container(),
    //                             ]),
    //                           ),
    //                         ),
    //                       ];
    //                     },
    //                     body: screens[currentIndex])),
    //             DraggableFloatingActionButton(
    //               isExtended: true,
    //               offset: new Offset(0, 200),
    //               backgroundColor: Colors.green,
    //               child: new Icon(
    //                 Icons.speed_rounded,
    //                 color: Colors.white,
    //               ),
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => SettingsScreen(),
    //                   ),
    //                 );
    //               },
    //               appContext: context,
    //               data: 'your_data',
    //             ),
    //           ],
    //         ),

    //   bottomNavigationBar: CustomNavigationBar(
    //   key: _bottomNavigationKey,
    //   iconSize: 30.0,
    //   selectedColor: Colors.white,
    //   strokeColor: Colors.white,
    //   unSelectedColor: Colors.grey[600],
    //   backgroundColor: Colors.black,
    //   borderRadius: Radius.circular(20.0),
    //   blurEffect: true,
    //   index: currentIndex,
    //   opacity: 0.8,
    //   items: [
    //     CustomNavigationBarItem(
    //       icon: Icon(
    //         Icons.home,
    //       ),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(
    //         Icons.shopping_cart,
    //       ),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(
    //         Icons.cloud,
    //       ),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(
    //         Icons.search,
    //       ),
    //     ),
    //     CustomNavigationBarItem(
    //       icon: Icon(Icons.supervised_user_circle),
    //     ),
    //   ],
    //   currentIndex: _currentIndex,
    //   onTap: (index) {
    //     setState(() {
    //       _currentIndex = index;
    //     });
    //   },
    //   isFloating: true,
    //   letIndexChange: (index) => true,
    // ),

    // bottomNavigationBar: CurvedNavigationBar(
    //   key: _bottomNavigationKey,
    //   index: currentIndex,
    //   height: 50.0,
    //   items: <Widget>[
    //     Container(
    //       height: 40,
    //       width: 40,
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage('assets/images/uzmob/uzmob.png'),
    //       ),
    //     ),
    //     Container(
    //       height: 40,
    //       width: 40,
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage('assets/images/ucell/ucell.jpg'),
    //       ),
    //     ),
    //     Container(
    //       height: 40,
    //       width: 40,
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage('assets/images/beeline/beelogo.png'),
    //       ),
    //     ),
    //     Container(
    //       height: 40,
    //       width: 40,
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage('assets/images/mobi/mobi.png'),
    //       ),
    //     ),
    //     Container(
    //       height: 40,
    //       width: 40,
    //       child: CircleAvatar(
    //         backgroundImage: AssetImage('assets/images/operator.png'),
    //       ),
    //     ),
    //   ],
    //   color: Colors.black12,
    //   buttonBackgroundColor: Colors.white54,
    //   backgroundColor: Colors.white54,
    //   animationCurve: Curves.easeInOut,
    //   animationDuration: Duration(milliseconds: 500),
    //   onTap: (index) {
    //     setState(() {
    //       currentIndex = index;
    //     });
    //   },
    //   letIndexChange: (index) => true,
    // ),
    // );
  }
}
