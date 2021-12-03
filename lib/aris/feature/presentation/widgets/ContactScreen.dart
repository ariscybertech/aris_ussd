import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<String> attachments = [];
  bool isHTML = false;
  final _recipientController = TextEditingController(
    text: 'ulugbektashmuratov@gmail.com',
  );

  final _subjectController = TextEditingController(text: 'Matn');

  final _bodyController = TextEditingController(
    text: 'Xabar.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
      isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  _instagram() async {
    const url = 'https://instagram.com/buum.uz?igshid=w12mekxyr5bp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _telegram() async {
    const url = 'https://t.me/joinchat/xQ9kv27K07E5MjEy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: ListView(
          children: [
            Container(
              height: 30,
              child: Center(
                child: Text(
                  'Biz bilan bog\'laning',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                height: 2,
                color: Colors.black87,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.phone,color: Colors.green,size: 30,),
                      Text('+998971564000',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.phone,color: Colors.green,size: 30,),
                      Text('+998903273336',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 22),)
                    ],
                  ),
                ),
              ],
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async{
                          await _telegram();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              image:
                                  AssetImage('assets/images/social/tg-min.png'),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              image:
                                  AssetImage('assets/images/social/fb-min.png'),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          await _instagram();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/social/ins-min.png'),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Image(
                              image: AssetImage(
                                  'assets/images/social/call-min.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 30,
                child: Center(
                  child: Text(
                    'Xabar yuborish',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                height: 2,
                color: Colors.black87,
              ),
            ),
            Container(
              height: 400,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     controller: _recipientController,
                  //     decoration: InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       labelText: 'Recipient',
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mavzusi',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _bodyController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: InputDecoration(
                            labelText: 'Xabar', border: OutlineInputBorder()),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    send();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                          child: Image(
                        image: AssetImage('assets/images/social/sendmail.png'),
                        color: Colors.white,
                      )),
                      Text(
                        'Yuborish',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
