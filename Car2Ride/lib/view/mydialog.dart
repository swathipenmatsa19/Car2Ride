import 'package:flutter/material.dart';

class MyDialog{

  static void info({
    @required BuildContext context,
    @required String title,
    @required String message,
    @required Function action,
    //@required Function action1,
  }){

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('OK',style: TextStyle(color: Colors.black),),
              onPressed: action,
            ),
          ],
        );
      },
    );
  }
 

  static void testAlert(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('Choose from below options'),
          content: Text('pic uploaded successfully in cloud storage!!'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK',style: TextStyle(color: Colors.black),),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  

  static void showProgressBar(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => 
           Center(child: CircularProgressIndicator())
    );
  }

  static void popProgressBar(BuildContext context){
    Navigator.pop(context);
  }

}