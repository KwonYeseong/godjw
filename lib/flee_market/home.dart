// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'service/manage_item.dart';
import 'detail.dart';
import 'data_structure.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

manage_items Manage_items = new manage_items();

double searchPrice = 0.0;
String searchWord = "";


TextEditingController search_field = new TextEditingController();

class FleeHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FleeHomePage> {

Widget _buildCardWithQuery(BuildContext context) {
    if (searchWord.length > 0.0 && searchPrice == 0.0) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('item').where(
            "name", isEqualTo: searchWord).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        },
      );
    }

    else if (searchWord.length <= 0.0 && searchPrice <=0.0) {
      return StreamBuilder<QuerySnapshot> (
        stream: Firestore.instance.collection('item').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        },
      );
    }

    else if (searchPrice > 0.0 && searchPrice < 350.0 && searchWord.length == 0.0) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('item').where(
            "price", isLessThanOrEqualTo: searchPrice).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        },
      );
    }

    else if (searchPrice > 0.0 && searchPrice < 350.0 && searchWord.length > 0.0) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('item')
            .where("price", isLessThanOrEqualTo: searchPrice)
            .where("name", isEqualTo: searchWord)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        },
      );
    }
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 1,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 7.0 / 5.8,
      children: snapshot.map((data) => _buildGridCards(context, data)).toList(),
    );
  }

  Widget _buildGridCards(BuildContext context, DocumentSnapshot data){
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());
    final record = Record.fromSnapshot(data);

    return Card(
      key: ValueKey(record.name),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 20 / 11,
            child: Image.network(
              record.photoURL,
              fit: BoxFit.fitWidth,
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:5.0),
                    Text(record.name, textAlign: TextAlign.start, style: TextStyle(fontSize: 18.0),),
                    Text(formatter.format(record.price)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailPage(record: record)));
                            },
                            child: Text("more", style: TextStyle(fontSize: 20),))
                          ],
                        ),
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('Flee Market', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white),
      body: Container(
        padding: EdgeInsets.all(7.0),
        child: Column(
          children: <Widget>[
            SizedBox(width: 20.0, height: 20.0,),
            Row(
              children: <Widget>[
                SizedBox(width: 20.0, height: 10.0,),
                Flexible(
                  child: TextField(
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.done,
                    controller: search_field,
                    decoration: new InputDecoration(
                        filled: false),
                    onChanged: (text) {
                      setState(() {
                        searchWord = text;
                      });
                    },
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                      });

                    }
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Slider(
                    activeColor: Colors.black,
                    inactiveColor: Colors.black,
                    value: searchPrice,
                    max: 300.0, min: 0.0, divisions: 60,
                    onChanged: (double value) {
                      setState(() {
                        searchPrice = value;
                      });
                    }),
                Text('\$$searchPrice'),
                SizedBox(width: 20.0,)
              ],
            ),

            Expanded(child: _buildCardWithQuery(context)
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add_page");
        },
        child: Icon(Icons.add, color: Colors.white,)
      ),
    );
  }
}

