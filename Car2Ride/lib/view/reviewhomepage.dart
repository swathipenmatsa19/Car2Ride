import 'package:bookreview/controller/reviewhomepage_controller.dart';
import 'package:bookreview/model/review.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/review.dart';
import '../model/car.dart';
import '../controller/reviewhomepage_controller.dart';

class ReviewHomePage extends StatefulWidget{

  final Car car;
  final List<Review> reviewList;
  
  ReviewHomePage(this.car,this.reviewList);

  @override
  State<StatefulWidget> createState() {
    return ReviewHomePageState(car,reviewList);
  }

}

class ReviewHomePageState extends State<ReviewHomePage>{

  Car car;
  Review reviewCopy;
  ReviewHomePageController controller;
  BuildContext context;
  List<Review> reviewList;
  List<int> deleteIndices;
  int _cIndex = 0;

  ReviewHomePageState(this.car,this.reviewList){
    controller = ReviewHomePageController(this);
  }
  var formKey = GlobalKey<FormState>();

  void stateChanged(Function fn){
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
          onWillPop: (){return Future.value(true);},
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Car Reviews",
                style: TextStyle(fontSize: 20.0 ,color: Colors.black),
              ),
            ],
          ),
        ),
        elevation: 4.0, 
        centerTitle: true,
        actions: <Widget>[
          
        ],
        ),
       

       
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.addReview,
        ),

        body: ListView.builder(
          
          itemCount: reviewList.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              padding: EdgeInsets.all(5.0),
              color: deleteIndices != null && deleteIndices.contains(index) ?
              Colors.cyan[200] : Colors.white,
              child: ListTile(
                      title: Text(reviewList[index].reviewName),
                // subtitle: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Text(carList[index].documentId),
                //     Text(carList[index].price.toString()),
                //     Text(carList[index].makeYear.toString()),
                //   ],
                // ),
                //onTap:()=> controller.onTap(index),
                //onLongPress: () => controller.longPress(index),
              ),
            );
          },
        ),
        
      ),
    );
  }

}
	
	
	
