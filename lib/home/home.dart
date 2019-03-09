import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:godjw/login.dart';
import 'package:godjw/widgets/custom.app.bar.dart';
import 'package:screentheme/screentheme.dart';

import 'data.dart';
import 'intro_page_item.dart';
import 'page_transformer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double subTitleSize = 20.0;

  @override
  void initState() {
    super.initState();
    var _duration = new Duration(seconds: 1);
    Timer(_duration, () {
      ScreenTheme.darkStatusBar(platform: Platform.iOS);
      ScreenTheme.darkStatusBar(platform: Platform.Android);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          title: GestureDetector(
        child: Text("ESC", style: TextStyle(color: Colors.black)),
        onTap: () {
          FirebaseAuth.instance.signOut().then((void v) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return LoginPage();
            }), ModalRoute.withName('/login'));
          });
        },
      )),
      body: ListView(
        children: <Widget>[
          SizedBox.fromSize(
            size: const Size.fromHeight(400.0),
            child: PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.85),
                  itemCount: sampleItems.length,
                  itemBuilder: (context, index) {
                    final item = sampleItems[index];
                    final pageVisibility =
                        visibilityResolver.resolvePageVisibility(index);

                    return IntroPageItem(
                      item: item,
                      pageVisibility: pageVisibility,
                    );
                  },
                );
              },
            ),
          ),

          //TODO : 중고템들
          Container(
            margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 6),
                Text("최근 올라온 중고품",
                    style: TextStyle(
                        fontSize: subTitleSize, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Container(
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Container(
                        //height: 200,
                        width: 160,
                        decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.grey[600]),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 140,
                                width: 140,
                                child: Image.network(
                                    sampleUsedItem[index].imageUrl,
                                    fit: BoxFit.fill),
                              ),
                              SizedBox(height: 15.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    sampleUsedItem[index].name,
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5.0),
                                  new Text(
                                    sampleUsedItem[index].price,
                                    style: new TextStyle(
                                        fontSize: 10.0, color: Colors.grey),
                                  ),
                                ],
                              )
                            ]),
                      ));
                    },
                    itemCount: sampleItems.length,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 12),

          //TODO : 팁들
//          Container(
//            margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
//            decoration: new BoxDecoration(
//              border: new Border.all(color: Colors.grey),
//              borderRadius: BorderRadius.all(Radius.circular(5.0)),
//            ),
//            padding: EdgeInsets.all(12.0),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text("실시간 인기 팁",
//                    style:
//                    TextStyle(fontSize: subTitleSize, fontWeight: FontWeight.bold)),
//                SizedBox(height: 12),
//                Container(
//                  height: 230,
//                  child: ListView.builder(
//                    itemBuilder: (context, index) {
//                      return Card(
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(Tips[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                            Text(Tips[index].content, style: TextStyle(fontSize: 12))
//
//                          ],
//                        ),
//                      );
//                    },
//                    itemCount: Tips.length,
//                  ),
//                )
//              ],
//            ),
//          ),
        ],
      ),
    );
  }
}
