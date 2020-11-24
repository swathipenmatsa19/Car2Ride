
import 'package:flutter/material.dart';

//import '../controller/signuppage_controller.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:bookreview/model/user.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as P;
import '../controller/profilepage_controller.dart';
import '../view/mydialog.dart';
import '../model/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage(this.user);
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(user);
  }
}

class ProfilePageState extends State<ProfilePage> {
  User user;
  User userCopy;

  ProfilePageController controller;
  var formKey = GlobalKey<FormState>();
  ProfilePageState(this.user) {
    controller = ProfilePageController(this);

    // if (user == null) {
    //   userCopy = user.empty();
    // } else {
    //   userCopy = User.clone(user);
    // }
  }

  

  File _image;
  Future getImage() async {

    //var image;
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {

    //var image;
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future uploadPic(BuildContext context) async {
    //String fileName = basename(_image.path);
    //print("Test*******"+_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('photos/${P.basename(_image.path)}}');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    MyDialog.testAlert(context);
    // showSnackBar(context){
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Pic uploaded!!"),
    //     )
    //   );
    // }
        setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Profle Picture Uploaded')));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
           // CachedNetworkImage(
            //   imageUrl: userCopy.,
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   errorWidget: (context, url, error) =>
            //       Icon(Icons.error_outline, size: 250),
            //   height: 250,
            //   width: 250,
            // ),
            Row(
              children: <Widget>[
                
                Center(
                  child: CircleAvatar(
                    radius: 100,
                              backgroundColor: Color(0xff476cfb),
                              child: ClipOval(
                                child: SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (_image != null)
                                      ? Image.file(_image, fit: BoxFit.fill)
                                      : Image.asset('assets/images/carimage1.jpg',
                                          fit: BoxFit.fill),
                                ),
                              ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.camera,
                                  size: 30.0,
                  ),
                  onPressed:(){
                    getImage();
                    },
                ),
                IconButton(
                  //padding: EdgeInsets.only( right:50),
                  icon: Icon(
                    FontAwesomeIcons.photoVideo,
                                  size: 30.0,
                  ),
                  onPressed:(){
                    getImageFromGallery();
                    },
                ),
              ],
            ),
             TextFormField(
              initialValue: user.email,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Email (as login name)',
                labelText: 'Email'
              ),
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            TextFormField(
              initialValue: user.displayName,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Display Name',
                labelText: 'Display Name'
              ),
              validator: controller.validateDisplayName,
              onSaved: controller.saveDisplayName,
            ),
            TextFormField(
              initialValue: '${user.zip}',
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Zip Code',
                labelText: 'zip'
              ),
              validator: controller.validateZip,
              onSaved: controller.saveZip,
            ),

             
            //  validator: controller.validateZip,
              //onSaved: controller.saveZip,
            
            RaisedButton(
              child: Text('Save'),
              onPressed: controller.submit,
            ),
            RaisedButton(
              child: Text('Upload Pic'),
              onPressed: () {
                               uploadPic(context);
                      },
            ),
          ],
        ),
      ),
    );
  }

}