import 'package:flutter/widgets.dart';

import './myfirebase.dart';

import '../view/signuppage.dart';
import '../view/mydialog.dart';

class SignUpPageController{

  SignUpPageState state;

  SignUpPageController(this.state);

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

  void createAccount() async{
    if(!state.formKey.currentState.validate()){
      return;
    }

    state.formKey.currentState.save();

    //using email/password: signup an account at Firebase
    try{
      state.user.uid = await MyFireBase.createAccount(
      email: state.user.email,
      password: state.user.password,
    );    
    }catch(e){
      MyDialog.info(
        context: state.context,
        title: 'Account creation failed!',
        message: e.message != null ? e.message : e.toString(),
        action: () => Navigator.pop(state.context),
      );

      return; //do not proceed
    }

    //create user profile
    try{
    MyFireBase.createProfile(state.user);
    }catch(e){
      state.user.displayName = null;
      state.user.zip = null;
    }

    MyDialog.info(
        context: state.context,
        title: 'Account creation Successfully!',
        message: 'Your account is created with ${state.user.email}',
        action: () => Navigator.pop(state.context),
      );
    
  }

}