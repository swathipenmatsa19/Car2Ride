import 'package:bookreview/controller/frontpage_controller.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';

class FrontPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FrontPageState();
  }

}


class FrontPageState extends State<FrontPage>{

  FrontPageController controller;
  BuildContext context;
  var user = User();
  var formKey = GlobalKey<FormState>();

  FrontPageState(){
    controller = FrontPageController(this);
  }

  void stateChanged(Function fn){
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Car2Ride",
                style: TextStyle(fontSize: 20.0 ,color: Colors.black),
              ),
              new Text(
                "Drive Yourself",
                style: TextStyle(fontSize: 10.0,color: Colors.black),
              ),
            ],
          ),
        ),
        elevation: 4.0, 
        centerTitle: true,
        automaticallyImplyLeading: false,
        // actions: <Widget>[
        //   FlatButton.icon(
        //     icon: Icon(Icons.people, color: Colors.white,),
        //     label: Text('Create Account',style: TextStyle(color:Colors.white),),
        //     onPressed: controller.createAccount,
        //   ),
        // ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white12,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/carimage1.jpg"),  
            fit: BoxFit.fill,
          ),
          ),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              // Center(
              //   child: Image.asset(
              // 'assets/images/carimage.jpg',
              // width: size.width,
              // height: size.height,
              // fit: BoxFit.fill,
              // )),
              Column(
                children: <Widget>[
                  FlutterLogo(

                  )
                ],
              ),
              TextFormField(
                initialValue: user.email,
                decoration: InputDecoration(
                  labelText: 'Enter email as login name',
                  hintText: 'email'
                ),
                keyboardType: TextInputType.emailAddress,
                validator: controller.validateEmail,
                onSaved: controller.saveEmail,
              ),
              TextFormField(
                initialValue: user.password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  hintText: 'password'
                ),
                validator: controller.validatePassword,
                onSaved: controller.savePassword,
              ),
              RaisedButton(
                child: Text('Log In'),
                onPressed: controller.login,
              ),
              FlatButton(
                child: Text('Forgot Password?'),
                onPressed: controller.resetPassword,
              ),
              FlatButton(
                child: Text('Dont have an account? Tap here to register.'),
                onPressed: controller.createAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

}