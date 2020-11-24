import 'package:bookreview/view/resetpassword.dart';
import '../controller/myfirebase.dart';
import '../view/mydialog.dart';
import 'package:flutter/material.dart';

class ResetPasswordController{

 RPState state;
 String email;

 ResetPasswordController(this.state);

 String validateEmail(String value){
   email = value;
    if(value == null || value.length < 6){
      return 'Enter email';
    }
    return null;
  }

  void saveEmail(String value){
    state.user.email = value;
  }

   

 void submit() async{

   if(state.formKey.currentState.validate()){
       state.formKey.currentState.save();
    }
   try{
   await MyFireBase.resetPassword(state.user.email);
   MyDialog.info(
       context: state.context,
       title: 'Reset password Success',
       message: ' Email sent Successfully!!',
       action:(){
         Navigator.pop(state.context); //dispose this dialog
       });
   //print('Email: ' + state.user.email);
   }catch(e){
     MyDialog.info(
       context: state.context,
       title: 'Reset password Error',
       message: ' Please check your email',
       action:(){
         Navigator.pop(state.context); //dispose this dialog
       });
   }
 }

}