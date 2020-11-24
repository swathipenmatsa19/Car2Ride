import '../view/userhomepage.dart';
import 'package:flutter/material.dart';
import '../view/timer.dart';
import '../controller/myfirebase.dart';
import '../view/frontpage.dart';
import '../view/searchpage.dart';
import '../view/filterpage.dart';
import '../view/profilepage1.dart';
import '../view/usercarpage.dart';
import '../model/car.dart';
import '../view/chatscreen.dart';

class UserHomePageController{
  UserHomePageState state;

  UserHomePageController(this.state);

  void timer() async{
    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => TimerApp(),
    ));
  }

   void signOut(){
    MyFireBase.signOut();
    Navigator.pop(state.context); //to close the drawer at homepage
    //Navigator.pop(state.context); //to return to the front page
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => FrontPage(),
    ));
  }

  void search(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => SearchPage(state.user,state.carList),
    ));
  }

  void filter(int index){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => FilterPage(state.user,state.carList),
    ));
  }

  void profile(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ProfilePage(state.user),
    ));
  }
  
  void onTap(int index) async{
    if(state.deleteIndices == null){
      //navigate to bookpage
      Car b = await Navigator.push(state.context, MaterialPageRoute(
        builder: (context) => UserCarPage(state.user, state.carList[index])
      ));

      if(b != null){
        //updated book is stored in Firebase
        state.carList[index] = b;
      }
    }else{
      
      state.setState((){
        //add to delete list
      if(state.deleteIndices.contains(index)){
        //tapped again -> deselect
        state.deleteIndices.remove(index);
        if(state.deleteIndices.length == 0){
          //all deselected. delete mode quits
          state.deleteIndices = null;
        }
      }else{
        state.deleteIndices.add(index);
      }
      });
    }
  }

  void onChat(){
     Navigator.push(state.context, MaterialPageRoute(
        builder: (BuildContext context){return ChatScreen();}
      ));
    
  }

}