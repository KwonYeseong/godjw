import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godjw/chat/chat_room.dart';
import 'package:godjw/utils/date.util.dart';
import 'package:godjw/widgets/custom.app.bar.dart';
import 'package:godjw/widgets/profile.image.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Text("Chats", style: TextStyle(color: Colors.black)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('ChatRooms')
            .orderBy("lastAdded", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatRoomPage(
                                  roomId:
                                      snapshot.data.documents[index].data['id'],
                                  roomNm: snapshot
                                      .data.documents[index].data['name'],
                                )));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 8.0, right: 8.0, bottom: 8.0),
                              child: ProfileImg(
                                url: snapshot.data.documents[index].data['img'],
                                ratio: 0.13,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        snapshot
                                            .data.documents[index].data['name'],
                                        style: TextStyle(
                                            color: Color(0xff717072),
                                            fontSize: 18),
                                      ),
                                      Text(
                                        DateTimeUtil.dateSub(snapshot
                                                .data
                                                .documents[index]
                                                .data['lastAdded']) ??
                                            "",
                                        style:
                                            TextStyle(color: Color(0xffA5A4A5)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5, width: 10),
                                  Text(
                                    snapshot.data.documents[index]
                                            .data['lastMsg'] ??
                                        "",
                                    style: TextStyle(color: Color(0xffA5A4A5)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
