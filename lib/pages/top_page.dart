import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_project/utils/fire_base.dart';
import 'package:flutter/material.dart';
import 'package:first_project/model/talk_room.dart';
import 'package:first_project/model/user.dart';
import 'package:first_project/pages/settings_profile.dart';
import 'package:first_project/pages/talk_room.dart';
import 'package:first_project/utils/shared_prefs.dart';




class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<TalkRoom> talkUserList = [];

  Future<void> createRooms() async{
    String myUid = SharedPrefs.getUid();
    print('myUid is');
    print(myUid);
    talkUserList = await Firestore.getRooms(myUid);
    print('talkUserList is--------------------------');
    print(talkUserList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('チャットアプリだよ'),
        actions:[
          IconButton(
            icon:Icon(Icons.settings),
            onPressed:(){
              Navigator.push(context,MaterialPageRoute(builder:(context) => SettingsProfilePage()));
            }
          )
        ]
      ),
      // body:Center(child: Text('toppage')),
      body:StreamBuilder<QuerySnapshot>(
        stream: Firestore.roomSnapshot,
        builder: (context, snapshot) {
          return FutureBuilder(
            future: createRooms(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
              print("roaded-----------------------------$talkUserList");
              return ListView.builder(
                  itemCount: talkUserList.length,
                  itemBuilder:(context, index){

                    return InkWell(
                      onTap: (){
                        print(talkUserList[index].roomId);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TalkRoomPage(talkUserList[index])));
                      },
                      child: Container(
                        height:70,
                        child:Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0,vertical:5.0),
                              child:CircleAvatar(
                                backgroundImage:NetworkImage(talkUserList[index].talkUser.imagePath),
                                radius:30,
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                Text(talkUserList[index].talkUser.name,style:TextStyle(fontSize: 18, fontWeight:FontWeight.bold),),
                                Text('userList[index].lastMessage',style:TextStyle(color:Colors.grey),),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
              );

             }else{
                return Center(child: CircularProgressIndicator());
              }

            }

          );
        }
      ),
      );

    // return Container();
  }
}


