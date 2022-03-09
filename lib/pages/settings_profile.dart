import 'dart:io';

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

  Future<void> getImageFromGallery() async {
    print('in getImageFromGallery-------------');
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('not nll');
      _image = File(pickedFile.path);
      setState(() {

      });
    }

    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //   }
    // });


  }

  // @override
  // void initState() {
  //   image = ;
  //   super.initState();
  // }

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
                Expanded(child:TextField()),
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
            )
    ]

    ),
    )
    );
  }
}













