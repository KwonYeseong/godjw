import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:godjw/utils/date.util.dart';
import 'package:godjw/utils/user.utils.dart';
import 'package:godjw/widgets/column.builder.dart';
import 'package:godjw/widgets/custom.app.bar.dart';

class ChatRoomPage extends StatefulWidget {
  final String roomId;
  final String roomNm;

  ChatRoomPage({this.roomId, this.roomNm});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(widget.roomNm, style: TextStyle(color: Colors.black)),
        leading: BackButton(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('ChatRooms')
            .document(widget.roomId)
            .collection('Chats')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  reverse: true,
                  shrinkWrap: true,
                  children: [
                    ColumnBuilder(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Bubble(
                            message:
                                snapshot.data.documents[index].data['message'],
                            time: DateTimeUtil.dateSub(snapshot
                                    .data.documents[index].data['id']) ??
                                "",
                            delivered: true,
                            isMe:
                                snapshot.data.documents[index].data['userId'] ==
                                    UserUtil.getUser().uid,
                            userNm:
                                snapshot.data.documents[index].data['userNm'],
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 5,
                width: 5,
              ),
              Divider(height: 1),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: _textEditingController,
                      maxLines: 1,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: InputBorder.none),
                    )),
                    MaterialButton(
                      onPressed: () {
                        sendChat();
                      },
                      child: Text("Send!"),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void sendChat() {
    String id = Timestamp.now().microsecondsSinceEpoch.toString();
    String text = _textEditingController.text;

    Firestore.instance
        .document('/ChatRooms/${widget.roomId}/Chats/$id')
        .setData({
      'userId': UserUtil.getUser().uid,
      'userNm': UserUtil.getUser().name,
      'profileUrl': UserUtil.getUser().profileUrl,
      'message': text,
      'id': id
    }).then((onValue) {
      _textEditingController.clear();
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    });

    Firestore.instance
        .document('/ChatRooms/${widget.roomId}')
        .setData({'lastMsg': text, 'lastAdded': id}, merge: true);
  }
}

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time, this.delivered, this.isMe, this.userNm});

  final String message, time, userNm;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = !isMe ? Colors.white : Colors.greenAccent.shade100;
    final align = !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = !isMe
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          !isMe ? Text(userNm) : Container(),
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 48.0),
                  child: Text(message),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: <Widget>[
                      Text(time,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10.0,
                          )),
                      SizedBox(width: 3.0),
                      Icon(
                        icon,
                        size: 12.0,
                        color: Colors.black38,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
