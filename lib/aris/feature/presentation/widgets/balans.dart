import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aris_ussd/aris/Screens/HomePage.dart';

class BalansWidget extends StatefulWidget {
  final String title;
  final String code;
  final Color color;
  final Color colorText;

  const BalansWidget({Key key, this.title, this.code, this.color, this.colorText}) : super(key: key);

  @override
  _BalansWidgetState createState() => _BalansWidgetState();
}

class _BalansWidgetState extends State<BalansWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: ()async{
          var wait = await HomePage.launchUssd(widget.code);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(
                  8.0,
                  8.0,
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
          ),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 70,
          child: Center(
            child: Text('${widget.title}', style: TextStyle(
                color: widget.colorText, fontSize: 18, fontWeight: FontWeight.bold,),),
          ),
        ),
      ),
    );
  }
}
