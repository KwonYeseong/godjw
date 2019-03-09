import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data_structure.dart';
import 'edit.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
String uid;

class DetailPage extends StatefulWidget {
  final Record record;
  DetailPage({Key key, this.record}) : super(key :key);

  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> {

  Future<String> getUID() async {
    FirebaseUser user = await _auth.currentUser();
    uid = user.uid.toString();
  }

  @override
  void initState() {
    getUID();
  }

  @override
  void setState(fn) {
    getUID();
    super.setState(getUID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: uid == widget.record.UID.toString() ? AppBar(
        title: Text('Flee Market', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel", style: new TextStyle(fontSize: 7.0))),

        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditPage(record: widget.record)));
              },
              icon: Icon(Icons.create),
          ),
          IconButton(
            onPressed: () {
              Addfunc.delData(widget.record.create_time);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ) : AppBar(
          title: Text('Flee Market', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel", style: new TextStyle(fontSize: 7.0))),

      ),

      body: Column(
        children: <Widget>[
          Image.network(widget.record.photoURL,
            width: 414.0,
            height: 300.0,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 32.0),
          Text(widget.record.name, style: TextStyle(fontSize: 16.0),),
          SizedBox(height: 32.0),
          Text("\$" + widget.record.price.toString(),  style: TextStyle(fontSize: 16.0),),
          SizedBox(height: 32.0),
          Text(widget.record.description, style: TextStyle(fontSize: 16.0),),
          SizedBox(height: 50.0),

          Column(
            children: <Widget>[
              Text("creator: " + widget.record.UID),
              Text("create_time: " + widget.record.create_time),
              Text("modified_time: " + widget.record.modified_time)
            ],
          )
        ],
      ),
    );
  }

}
