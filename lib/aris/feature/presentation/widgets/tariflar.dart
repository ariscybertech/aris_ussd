import 'dart:convert';
import 'dart:io';

import 'package:aris_ussd/aris/feature/presentation/widgets/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TarifScreen extends StatefulWidget {
  final Color appBarColor;
  final Color textColor;
  final Color borderColor;
  final int len;
  final String root;
  final String image;

  const TarifScreen(
      {Key key,
      this.appBarColor,
      this.textColor,
      this.borderColor,
      this.len,
      this.root,
      this.image})
      : super(key: key);

  @override
  _TarifScreenState createState() => _TarifScreenState();
}

class _TarifScreenState extends State<TarifScreen> {
  final controller = PageController(viewportFraction: 1.0);
  File file;
  var myData;
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Tariflar',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                    child: FutureBuilder(
                  future:
                      getString(),
                  builder: (context, snapshot) {
                    return PageView(
                      controller: controller,
                      children: List.generate(
                        (myData == null) ? 0 : myData.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          '${myData[index]['tarif_name']}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${myData[index]['tarif_price']}',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '/${myData[index]['davomiyligi']}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListView(
                                        children: [
                                          (myData[index]['title_1'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: widget
                                                              .appBarColor),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                child: Container(
                                                                    child: Text(
                                                          '${myData[index]['title_1']}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        )))),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              child: Text(
                                                            '${myData[index]['title_1_price']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (myData[index]['title_2'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: widget
                                                              .appBarColor),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                child: Container(
                                                                    child: Text(
                                                          '${myData[index]['title_2']}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        )))),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              child: Text(
                                                            '${myData[index]['title_2_price']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (myData[index]['title_3'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: widget
                                                              .appBarColor),
                                                    ),
                                                    child: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 18,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Container(
                                                                  child: Text(
                                                            '${myData[index]['title_3']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ))),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                child: Text(
                                                              '${myData[index]['title_3_price']}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (myData[index]['title_4'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: widget
                                                              .appBarColor),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                child: Text(
                                                          '${myData[index]['title_4']}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ))),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              child: Text(
                                                            '${myData[index]['title_4_price']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (myData[index]['title_5'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: widget
                                                                .appBarColor),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 18,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                                child: Text(
                                                              '${myData[index]['title_5']}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            )),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                child: Text(
                                                              '${myData[index]['title_5_price']}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (myData[index]['title_6'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: widget
                                                              .appBarColor),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                                child: Text(
                                                          '${myData[index]['title_6']}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                        ))),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                              child: Text(
                                                            '${myData[index]['title_6_price']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          (myData[index]['title_7'] != null)
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: widget
                                                                .appBarColor),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 18,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Container(
                                                                  child: Text(
                                                            '${myData[index]['title_7']}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ))),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                                child: Text(
                                                              '${myData[index]['title_7_price']}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .green),
                                                            )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        var wait = await HomePage.launchUssd(
                                            myData[index]['tarif_code']);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: widget.appBarColor,
                                        ),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:12.0),
                                                child: Text(
                                                  '${myData[index]['tarif_code']}',
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
                                                  Share.share('${myData[index]['tarif_name']} ${myData[index]['service_code']}');
                                                },
                                              ),
                                            ],
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
              Container(
                height: 30,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: widget.len,
                  effect: WormEffect(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
