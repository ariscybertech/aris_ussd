import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

import 'HomePage.dart';

class InternetScreen extends StatefulWidget {
  final Color appBarColor;
  final Color appBarColor1;
  final Color textColor;
  final Color borderColor;
  final List<Tab> tabList;
  final List tabServiceList;
  final String def;
  final String image;

  const InternetScreen(
      {Key key,
      this.appBarColor,
      this.textColor,
      this.tabList,
      this.tabServiceList, this.borderColor, this.def, this.appBarColor1, this.image})
      : super(key: key);

  @override
  _InternetScreenState createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Widget> tabBarViewScreen = [];

  parsingTabServiceList() {
    for (int k = 0; k < widget.tabServiceList.length; k++) {
      tabBarViewScreen.add(Container(
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: ()async{
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
                        ]
                    ),
                    height: 60,
                    width: 200,
                    child: Center(child: Text('QOLDIQNI TEKSHIRISH',style: TextStyle(color: widget.textColor,fontSize: 16),),),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PhysicalModel(
                          elevation: 1,
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
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
                                // border: Border.all(width: 2,color: widget.borderColor)
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${widget.tabServiceList[k][index]['service_name']}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        '${widget.tabServiceList[k][index]['service_price']}',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical:8.0),
                                  child: Container(
                                    child: Text('${widget.tabServiceList[k][index]['service_desc']}',style: TextStyle(fontSize: 14),),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: ()async{
                                      var wait = await HomePage.launchUssd('${widget.tabServiceList[k][index]['service_code']}');
                                    },
                                    child: PhysicalModel(
                                      elevation: 1,
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.green,
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
                                        ),

                                        height: 50,
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:12.0),
                                                child: Text(
                                                  '${widget.tabServiceList[k][index]['service_code']}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.share,color: Colors.white,size: 30,),
                                                onPressed: () {
                                                  Share.share('${widget.tabServiceList[k][index]['service_name']} ${widget.tabServiceList[k][index]['service_code']}');
                                                },
                                              ),
                                            ],
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.tabServiceList[k] == null ? 0 : widget.tabServiceList[k].length,
                  ),
                ),
              ),
            ],
          )
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    parsingTabServiceList();
    // print(widget.tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabList.length,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor:Colors.white,
          centerTitle: true,
          title: Text(
            'Internet',
            style: TextStyle(color: Colors.black, fontSize: 18),
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
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            tabs: widget.tabList,
            controller: _tabController,
          ),
        ),
        body: TabBarView(
          children: tabBarViewScreen,
          controller: _tabController,
        ),
      ),
    );
  }
}
