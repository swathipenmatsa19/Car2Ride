// //import 'package:bookreview/model/user.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'package:path/path.dart' as P;
// import '../controller/profilepage_controller.dart';
// import '../view/mydialog.dart';
// import '../model/user.dart';

// class ProfilePage extends StatefulWidget {

//   final User user;

//   ProfilePage(this.user);
//   @override
//   State<StatefulWidget> createState() {
//     return ProfilePageState(user);
//   }
// }

// class ProfilePageState extends State<ProfilePage> {
//   MyDialog dialog = MyDialog();
//   BuildContext context;
//   ProfilePageController controller;
//   User user;
//   var formKey = GlobalKey<FormState>();
//   ProfilePageState(this.user) {
//     controller = ProfilePageController(this);
//   }

//   void stateChanged(Function fn) {
//     setState(fn);
//   }



//   File _image;
//   Future getImage() async {

//     //var image;
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       _image = image;
//     });
//   }

//   Future getImageFromGallery() async {

//     //var image;
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = image;
//     });
//   }

//   Future uploadPic(BuildContext context) async {
//     //String fileName = basename(_image.path);
//     //print("Test*******"+_image.path);
//     StorageReference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child('photos/${P.basename(_image.path)}}');
//     StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//     StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//         setState(() {
//           print("Profile Picture uploaded");
//           Scaffold.of(context)
//               .showSnackBar(SnackBar(content: Text('Profle Picture Uploaded')));
//         });
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     this.context = context;
     
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(FontAwesomeIcons.arrowLeft),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         title: Text('Edit Profile'),
//       ),
//       body: Form(
//               child: Builder(
//             builder: (context) => Container(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Padding(
//                               padding: EdgeInsets.only(top: 60.0),
//                               child: IconButton(
//                                 icon: Icon(
//                                   FontAwesomeIcons.photoVideo,
//                                   size: 30.0,
//                                 ),
//                                 onPressed: () {
//                                   getImageFromGallery();
//                                 },
//                               )),
//                           Align(
//                             alignment: Alignment.center,
//                             child: CircleAvatar(
//                               radius: 100,
//                               backgroundColor: Color(0xff476cfb),
//                               child: ClipOval(
//                                 child: SizedBox(
//                                   width: 180.0,
//                                   height: 180.0,
//                                   child: (_image != null)
//                                       ? Image.file(_image, fit: BoxFit.fill)
//                                       : Image.network("https://images.un",
//                                           fit: BoxFit.fill),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                               padding: EdgeInsets.only(top: 60.0),
//                               child: IconButton(
//                                 icon: Icon(
//                                   FontAwesomeIcons.camera,
//                                   size: 30.0,
//                                 ),
//                                 onPressed: () {
//                                   getImage();
//                                 },
//                               )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                   child: Column(
//                                 children: <Widget>[
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       'Username',
//                                       style: TextStyle(
//                                           color: Colors.blueGrey, fontSize: 18.0),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       'Michel James',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 20.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   )
//                                 ],
//                               ))),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               child: Icon(
//                                 FontAwesomeIcons.pen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                   child: Column(
//                                 children: <Widget>[
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       'Email',
//                                       style: TextStyle(
//                                           color: Colors.blueGrey, fontSize: 18.0),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: TextFormField(
//                                       initialValue: user.email,
//                                        autocorrect: false,
//                                       decoration: InputDecoration(
//                                      hintText: 'Email (as login name)',
//                                      labelText: 'Email'
//                                       ),
//                                     validator: controller.validateEmail,
//                                     onSaved: controller.saveEmail,
//                                     ),
//                                   )
//                                 ],
//                               ))),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               child: Icon(
//                                 FontAwesomeIcons.pen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           Align(
//                               alignment: Alignment.centerLeft,
//                               child: Container(
//                                   child: Column(
//                                 children: <Widget>[
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       'Zipcode',
//                                       style: TextStyle(
//                                           color: Colors.blueGrey, fontSize: 18.0),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       '73034',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 20.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   )
//                                 ],
//                               ))),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                               child: Icon(
//                                 FontAwesomeIcons.pen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: <Widget>[
//                           RaisedButton(
//                             color: Color(0xff476cfb),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             elevation: 4.0,
//                             splashColor: Colors.blueGrey,
//                             child: Text(
//                               'Cancel',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16.0),
//                             ),
//                           ),
//                           RaisedButton(
//                             color: Color(0xff476cfb),
//                             onPressed: () {
//                               uploadPic(context);
//                             },
//                             elevation: 4.0,
//                             splashColor: Colors.blueGrey,
//                             child: Text(
//                               'Submit',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 16.0),
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 )),
//       ),
//     );
//   }
// }
