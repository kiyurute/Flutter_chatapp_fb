import 'package:first_project/model/user.dart';

class TalkRoom{
  String roomId;
  User talkUser;
  String lastMessage;

  TalkRoom({required this.roomId, required this.talkUser, required this.lastMessage});

}