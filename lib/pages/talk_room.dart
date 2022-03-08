import 'package:first_project/model/message.dart';
import 'package:first_project/model/talk_room.dart';
import 'package:first_project/utils/fire_base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../model/user.dart';


class  TalkRoomPage extends StatefulWidget {
  final TalkRoom room;
  TalkRoomPage(this.room);

  @override
  _TalkRoomPageState createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  List<Message> messageList = [];

  Future<void> getMessages() async{
    messageList = await Firestore.getMessages(widget.room.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
      title:Text(widget.room.talkUser.name),
    ),
      body:Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:60.0),
            child: FutureBuilder(
              future:getMessages(),
              builder: (context,snapshot) {
                return ListView.builder(
                    physics: RangeMaintainingScrollPhysics(),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      Message _message = messageList[index];
                      DateTime sendtime = _message.sendTime.toDate();
                      return Padding(
                        padding: EdgeInsets.only(top: 10.0,
                            right: 10.0,
                            left: 10.0,
                            bottom: index == 0 ? 10 : 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          textDirection: messageList[index].isMe ? TextDirection
                              .rtl : TextDirection.ltr,
                          children: [
                            Container(
                                constraints: BoxConstraints(maxWidth: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.7),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: messageList[index].isMe
                                      ? Colors.green
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: Text(messageList[index].message)
                            ),

                            Text(intl.DateFormat('HH:mm').format(
                                sendtime),
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    }
                );


              }
            ),
          ),
          Align(
            alignment:Alignment.bottomCenter,
            child: Container(
              height:60,color:Colors.white,
              child:Row(
                children:[
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border:OutlineInputBorder()
                      ),
                    ),
                  )),
                  IconButton(
                    icon:Icon(Icons.send),
                    onPressed: (){
                      print('送信');
                    },
                  )
                ]
              )
            )

          )
        ],
      ),
    );
  }
}