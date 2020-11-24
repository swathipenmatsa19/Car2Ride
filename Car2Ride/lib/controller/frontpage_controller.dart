
import '../controller/myfirebase.dart';
import 'package:bookreview/view/mydialog.dart';
import '../view/homepage.dart';
import '../view/frontpage.dart';
import 'package:flutter/material.dart';
import '../view/signuppage.dart';
import '../model/user.dart';
import '../model/car.dart';
import '../view/userhomepage.dart';
import '../view/resetpassword.dart';

class FrontPageController{

  FrontPageState state;

  FrontPageController(this.state);

  void createAccount(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => SignUpPage(), 
    ));
  }

  String validateEmail(String value){
    if(value == null || !value.contains('.') || !value.contains('@')){
      return 'Enter valid email address';
    }
    return null;
  }

  void saveEmail(String value){
    state.user.email = value;
  }

  String validatePassword(String value){
    if(value == null || value.length < 6){
      return 'Enter password';
    }
    return null;
  }

  void savePassword(String value){
    state.user.password = value;
  }

  void login() async{
    if(!state.formKey.currentState.validate()){
      return;
    }

    state.formKey.currentState.save();

    if(state.user.email != 'anilvallaba92@gmail.com'){
      MyDialog.showProgressBar(state.context);

    try{
    state.user.uid = await MyFireBase.login(
      email: state.user.email,
      password: state.user.password,
    );
    
    }catch(e){
      MyDialog.popProgressBar(state.context);
     MyDialog.info(
       context: state.context,
       title: 'Login Error',
       message: e.message != null ?e.message : e.toString(),
       action: () => Navigator.pop(state.context),
     );
     return; // do not proceed
    }

  // login success - read user profile

  try{
   User user = await MyFireBase.readProfile(state.user.uid);
   state.user.displayName = user.displayName;
   state.user.zip = user.zip;
  }catch(e){
    // no displayname and zip can be updated
    print('****READPROFILE****' + e.toString());
  }
   
   //read book reviews this user has created
  List<Car> carList;
  try{
    carList = await MyFireBase.getBooks();
  }catch(e){
    carList = <Car>[];
  }



    MyDialog.popProgressBar(state.context);

    MyDialog.info(
       context: state.context,
       title: 'Login Success',
       message: ' Press <OK> Navigate to User Home Page',
       action:(){
         Navigator.pop(state.context); //dispose this dialog
         Navigator.push(state.context, MaterialPageRoute(
           builder: (context) => UserHomePage(state.user,carList),
         ));
       });


    }else{

      MyDialog.showProgressBar(state.context);

    try{
    state.user.uid = await MyFireBase.login(
      email: state.user.email,
      password: state.user.password,
    );
    
    }catch(e){
      MyDialog.popProgressBar(state.context);
     MyDialog.info(
       context: state.context,
       title: 'Login Error',
       message: e.message != null ?e.message : e.toString(),
       action: () => Navigator.pop(state.context),
     );
     return; // do not proceed
    }

  // login success - read user profile

  try{
   User user = await MyFireBase.readProfile(state.user.uid);
   state.user.displayName = user.displayName;
   state.user.zip = user.zip;
  }catch(e){
    // no displayname and zip can be updated
    print('****READPROFILE****' + e.toString());
  }
   
   //read book reviews this user has created
  List<Car> carList;
  try{
    carList = await MyFireBase.getBooks();
  }catch(e){
    carList = <Car>[];
  }



    MyDialog.popProgressBar(state.context);

    MyDialog.info(
       context: state.context,
       title: 'Login Success',
       message: ' Press <OK> Navigate to Admin Home Page',
       action:(){
         Navigator.pop(state.context); //dispose this dialog
         Navigator.push(state.context, MaterialPageRoute(
           builder: (context) => HomePage(state.user,carList),
         ));
       });

    }

  //   MyDialog.showProgressBar(state.context);

  //   try{
  //   state.user.uid = await MyFireBase.login(
  //     email: state.user.email,
  //     password: state.user.password,
  //   );
    
  //   }catch(e){
  //     MyDialog.popProgressBar(state.context);
  //    MyDialog.info(
  //      context: state.context,
  //      title: 'Login Error',
  //      message: e.message != null ?e.message : e.toString(),
  //      action: () => Navigator.pop(state.context),
  //    );
  //    return; // do not proceed
  //   }

  // // login success - read user profile

  // try{
  //  User user = await MyFireBase.readProfile(state.user.uid);
  //  state.user.displayName = user.displayName;
  //  state.user.zip = user.zip;
  // }catch(e){
  //   // no displayname and zip can be updated
  //   print('****READPROFILE****' + e.toString());
  // }
   
  //  //read book reviews this user has created
  // List<Car> carList;
  // try{
  //   carList = await MyFireBase.getBooks(state.user.email);
  // }catch(e){
  //   carList = <Car>[];
  // }



  //   MyDialog.popProgressBar(state.context);

  //   MyDialog.info(
  //      context: state.context,
  //      title: 'Login Success',
  //      message: ' Press <OK> Navigate to User Home Page',
  //      action:(){
  //        Navigator.pop(state.context); //dispose this dialog
  //        Navigator.push(state.context, MaterialPageRoute(
  //          builder: (context) => HomePage(state.user,carList),
  //        ));
  //      });

  }

  void resetPassword(){
    Navigator.push(state.context, MaterialPageRoute(
           builder: (context) => ResetPassword(),
         ));
  }
  

}