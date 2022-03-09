import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_project/model/user.dart';
import 'package:first_project/utils/fire_base.dart';
import 'package:first_project/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SettingsProfile extends StatefulWidget {
  const SettingsProfile({Key? key}) : super(key: key);

  @override
  _SettingsProfileState createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  File? _image;
  final imagePicker = ImagePicker();
  String? imagePath;
  TextEditingController controller = TextEditingController();

  Future<void> getImageFromGallery() async {
    print('in getImageFromGallery-------------');
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('not null');
      _image = File(pickedFile.path);
      uploadImage();
      setState(() {});
    }

  }

  Future<String> uploadImage() async{
    // try {
    //   await FirebaseStorage.instance.ref('testimg.png').putFile(_image!);
    // } on FirebaseException catch (e) {
    //   print('in exception');
    //   print(e);
    // }

    final ref = FirebaseStorage.instance.ref('test_pic.png3');
    final storedImage = await ref.putFile(_image!);
    imagePath = await loadImage(storedImage);
    return imagePath.toString();


  }

  Future<String> loadImage(TaskSnapshot storedImage) async{
    String downloadUrl = await storedImage.ref.getDownloadURL();
    return downloadUrl;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title:Text('プロフィール編集'),
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
          children:[
            Row(
              children:[
                Container(width:100,child:Text('名前')),
                Expanded(child:TextField(
                  controller: controller,
                )),
              ]
            ),

            SizedBox(height:50),

            Row(
              children:[
                Container(width:100,child:Text('サムネイル')),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      width:150,height:40, child: ElevatedButton(
                        child: Text('画像を選択'),
                        onPressed: (){
                          print('img button pressed----------------------');
                          getImageFromGallery();
                        },

                        ),
                    ),
                  ),
                )
        ],

    ),
            SizedBox(height:30),

            _image == null ? Container() : Container(
              width:200,
              height:200,
              child:Image.file(_image!, fit:BoxFit.cover),
            ),

            SizedBox(height:30),
            ElevatedButton(
              onPressed:(){
                String uid = SharedPrefs.getUid();
                User newProfile = User(
                  name:controller.text,
                  imagePath: imagePath!,
                  uid: uid
                );
                Firestore.updateProfile(newProfile);
              },
              child:Text('編集'),
            )
    ]

    ),
    )
    );
  }
}













