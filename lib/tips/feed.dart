import 'package:flutter/material.dart';

import './Exfloating.dart';
import './event_list.dart';

class FeedPage extends StatefulWidget {
  @override
  FeedPageState createState() => FeedPageState();
}

class FeedPageState extends State<FeedPage> {
  //Ticket구매 Alert
  Widget _showAlert(Event event) {
    return new AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          MyDialogContent(event: event),
        ],
      ),
    );
  }

  //확장 이전 Card
  Widget _nonExpandedCard(Event event) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //사진부분
          Center(
              child: Container(
                  height: 240.0,
                  child:
                      Image.network(event.imageURL, width: 400, height: 300))),
          //내용부분
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(event.title,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                        maxLines: 1),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios,
                          size: 20.0, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          event.isExpanded = true;
                        });
                      },
                    ),
                  ],
                ),
                Text(event.details,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //확장 이후 Card
  Widget _expandedCard(Event event) {
    return Container(
      height: 600.0,
      child: Card(
        child: Scaffold(
          //사진부분
          body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0)),
                image: DecorationImage(
                    image: NetworkImage(event.imageURL), fit: BoxFit.cover)),
          ),
          //내용부분
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(event.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    maxLines: 1),
                Text(event.details,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: exampleEvents.map((event) {
        return event.isExpanded
            ? _expandedCard(event)
            : _nonExpandedCard(event);
      }).toList()),
      floatingActionButton: CustomFloatingActionButton(),
    );
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    Key key,
    this.event,
  }) : super(key: key);

  final Event event;

  @override
  _MyDialogContentState createState() =>
      new _MyDialogContentState(event: event);
}

class _MyDialogContentState extends State<MyDialogContent> {
  final Event event;
  _MyDialogContentState({@required this.event});

  _getContent() {
    return Container(
        height: 440,
        width: 400,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[]));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
