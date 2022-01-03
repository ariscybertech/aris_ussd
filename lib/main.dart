import 'package:aris_ussd/aris/feature/presentation/widgets/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
    bool isFirst;
    int k;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    k = prefs.getInt('isFirst');
    if(k == 1){ 
      // print(k);
      isFirst = false;
    }else{
      // print(k);
      isFirst = true;
    }
    HomePage.isFirst = isFirst;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
