import 'package:bookreview/controller/reviewpage_controller.dart';
import 'package:bookreview/model/review.dart';
import 'package:flutter/material.dart';
import '../model/car.dart';
import '../model/user.dart';
import '../controller/carpage_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReviewPage extends StatefulWidget{

  final Car car;
  final Review review;

  ReviewPage(this.car,this.review);

  @override
  State<StatefulWidget> createState() {
    return ReviewPageState(car,review);
  }

}

class ReviewPageState extends State<ReviewPage>{

 //User user;
 Car car;
 Review review;
 Review reviewCopy;
 ReviewPageController controller;
 var formKey = GlobalKey<FormState>();

 ReviewPageState(this.car,this.review){
   controller = ReviewPageController(this);
   //add button pressed
   if(review == null){
     reviewCopy = Review.empty();
   }else{
     reviewCopy = Review.clone(review);  //clone
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Add Review",
                style: TextStyle(fontSize: 20.0 ,color: Colors.black),
              ),
            ],
          ),
        ),
        elevation: 4.0, 
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: car.imageUrl,
              placeholder: (context,url) => CircularProgressIndicator(),
              errorWidget: (context,url,error) => Icon(Icons.error_outline,size:250),
              height: 250,
              width: 250,
            ),
            
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Write Review'
              ),
              autocorrect: false,
              //initialValue: carCopy.color,
              validator: controller.validateReview,
              onSaved: controller.saveReview,
            ),
            
            RaisedButton(
              child: Text('Save'),
              onPressed: controller.save,
            ),
          ],
        ),
      ),
    );
  }

}

	
	
	
