import '../view/mydialog.dart';
import '../view/profilepage1.dart';
//import '../view/profilepage.dart';
import 'package:flutter/material.dart';
import '../controller/myfirebase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
class ProfilePageController{
  ProfilePageState state;

  ProfilePageController(this.state);

    //  var image;
    // File _image;
    //   Future getImage() async{
    //        image = await ImagePicker.pickImage(source:ImageSource.camera);
           
    //        state.stateChanged(() {
    //          state._image=image;
    //        });

    //       //  state.stateChanged(
    //       //   state._image=image
    //       //  );
    //     }
      String validateEmail(String value){
    if(value == null || !value.contains('.') || !value.contains('@')){
      return 'Enter a valid Email address';
    }
    return null;
  }

  void saveEmail(String value){
    state.user.email = value;
  }

  String validatePassword(String value){
    if(value == null ){
      return 'Enter a password';
    }
    return null;
  }

  void savePassword(String value){
    state.user.password = value;
  }

  String validateDisplayName(String value){
    if(value == null || value.length < 3){
      return 'Enter atleast 3 chars';
    }
    return null;
  }

  void saveDisplayName(String value){
    state.user.displayName = value;
  }

  String validateZip(String value){
    if(value == null || value.length != 5){
      return 'Enter 5 digit ZIP code';
    }
    try{
      int n = int.parse(value);
      if(n < 10000){
        return 'Enter 5 digit ZIP code';
      }
    }catch(e){
      return 'Enter 5 digit ZIP code';
    }
    return null;
  }

  void saveZip(String value){
    state.user.zip = int.parse(value);
  }

  void submit() async{
    if(!state.formKey.currentState.validate()){
      return;
    }

    state.formKey.currentState.save();

    
    try{
      await MyFireBase.updateUser(state.user); 
      Navigator.pop(state.context, state.user);
     
    }catch(e){
      MyDialog.info(
        context: state.context,
        title: 'Updation failed!',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );

      return; //do not proceed
    }

    //create user profile
    // try{
    // MyFireBase.updateUser(state.user);
    // }catch(e){
    //   state.user.displayName = null;
    //   state.user.zip = null;
    // }

    MyDialog.info(
        context: state.context,
        title: 'Updated Successfully!',
        message: 'Your Details are updated succesfully',
        action: () {
        Navigator.pop(state.context);
        Navigator.push(state.context, MaterialPageRoute(
           builder: (context) => ProfilePage(state.user),
         ));
        }
      );
    
      //state.uploadPic(state.context);

  }

}

      

        


