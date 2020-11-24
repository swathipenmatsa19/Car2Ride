import 'package:flutter/material.dart';
import '../model/car.dart';
import '../model/user.dart';
import '../controller/usercarpage_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserCarPage extends StatefulWidget{

  final User user;
  final Car car;

  UserCarPage(this.user,this.car);

  @override
  State<StatefulWidget> createState() {
    return UserCarPageState(user,car);
  }

}

class UserCarPageState extends State<UserCarPage>{

 User user;
 Car car;
 Car carCopy;
 UserCarPageController controller;
 var formKey = GlobalKey<FormState>();

 UserCarPageState(this.user,this.car){
   controller = UserCarPageController(this);
   //add button pressed
   if(car == null){
     carCopy = Car.empty();
   }else{
     carCopy = Car.clone(car);  //clone
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
                "car details",
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
              imageUrl: carCopy.imageUrl,
              placeholder: (context,url) => CircularProgressIndicator(),
              errorWidget: (context,url,error) => Icon(Icons.error_outline,size:250),
              height: 250,
              width: 250,
            ),
    
                        
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child:Column(children: <Widget>[
                          Align(alignment: Alignment.centerLeft,
                          child: Text('CarName',
                          style:TextStyle(
                            color: Colors.blueGrey, fontSize: 18.0),
                          ),),
                          Align(alignment: Alignment.centerLeft,
                          child: Text(car.carName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                          ),)
                          ],)
                        )
                      ),
    
                    ],
                  
    
                 
    
    
                  ),
    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child:Column(children: <Widget>[
                          Align(alignment: Alignment.centerLeft,
                          child: Text('Color',
                          style:TextStyle(
                            color: Colors.blueGrey, fontSize: 18.0),
                          ),),
                          Align(alignment: Alignment.centerLeft,
                          child: Text(car.color,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                          ),)
                          ],)
                        )
                      ),
                    ],
                  ),



             Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child:Column(children: <Widget>[
                          Align(alignment: Alignment.centerLeft,
                          child: Text('Price',
                          style:TextStyle(
                            color: Colors.blueGrey, fontSize: 18.0),
                          ),),
                          Align(alignment: Alignment.centerLeft,
                          child: Text('${car.price}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                          ),)
                          ],)
                        )
                      ),
                    ],
                  ),


                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child:Column(children: <Widget>[
                          Align(alignment: Alignment.centerLeft,
                          child: Text('Make Year',
                          style:TextStyle(
                            color: Colors.blueGrey, fontSize: 18.0),
                          ),),
                          Align(alignment: Alignment.centerLeft,
                          child: Text('${car.makeYear}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                          ),)
                          ],)
                        )
                      ),
                    ],
                  ),

               Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xff476cfb),
                        onPressed: () {
                         // Navigator.of(context).pop();
                          
                        },
                        elevation: 4.0,
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'Book Car',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
    
                      ),
    
                       RaisedButton(
                        color: Color(0xff476cfb),
                        onPressed: controller.reviewPage,
                        elevation: 4.0,
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'View Reviews',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
    
                      )
                    ],
               ),   

      
          ],
        ),
       ),
    );
  }
}
	
