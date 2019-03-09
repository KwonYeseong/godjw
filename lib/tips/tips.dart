import 'package:flutter/material.dart';
import 'package:godjw/widgets/custom.app.bar.dart';

import './feed.dart';

class EventPage extends StatefulWidget {
  @override
  EventPageState createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  //Tabbar colors
  Color feedColor = Colors.white;
  Color calendarColor = Colors.grey;
  Color myReservColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Color(0xff2980c1),
        title: Text("Tips",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//        bottom: PreferredSize(
//            preferredSize: Size.fromHeight(27.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                      child: Text('피드',
//                          style: TextStyle(fontWeight: FontWeight.bold)),
//                      textColor: feedColor,
//                      onPressed: () {
//                        setState(() {
//                          feedColor = Colors.white;
//                          calendarColor = Colors.grey;
//                          myReservColor = Colors.grey;
//                        });
//                      }),
//                ),
//              ],
//            )),
      ),
      body: Container(child: FeedPage()),
    );
  }
}
