import 'package:flutter/material.dart';
import '../controller/resetpassword_controller.dart';
import '../model/user.dart';

class ResetPassword extends StatefulWidget{

  
  @override
  State<StatefulWidget> createState() {
    return RPState();
  }

}

class RPState extends State<ResetPassword>{
  
  ResetPasswordController controller;
  var user = User();
  BuildContext context;
  var formKey = GlobalKey<FormState>();

 RPState(){
   controller = ResetPasswordController(this);
 }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
             TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter email as login name',
                hintText: 'email'
              ),
              keyboardType: TextInputType.emailAddress,
              validator: controller.validateEmail,
              onSaved: controller.saveEmail,
            ),
            RaisedButton(
              child: Text('submit'),
              onPressed: controller.submit,
            ),
          ],
        ),
      ),
    );
  }

}