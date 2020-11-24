import 'package:flutter/material.dart';
import '../model/car.dart';
import '../model/user.dart';
import '../controller/carpage_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarPage extends StatefulWidget{

  final User user;
  final Car car;

  CarPage(this.user,this.car);

  @override
  State<StatefulWidget> createState() {
    return CarPageState(user,car);
  }

}

class CarPageState extends State<CarPage>{

 User user;
 Car car;
 Car carCopy;
 CarPageController controller;
 var formKey = GlobalKey<FormState>();

 CarPageState(this.user,this.car){
   controller = CarPageController(this);
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
            TextFormField(
              initialValue: carCopy.imageUrl,
              decoration: InputDecoration(
                labelText: 'Image',
              ),
              autocorrect: false,
              validator: controller.validateImageUrl,
              onSaved: controller.saveImageUrl,
            ),
            TextFormField(
              initialValue: carCopy.carName,
              decoration: InputDecoration(
                labelText: 'Car name',
              ),
              autocorrect: false,
              validator: controller.validateName,
              onSaved: controller.saveName,
            ),
            TextFormField(
              initialValue: '${carCopy.price}',
              decoration: InputDecoration(
                labelText: 'price (in dollars)',
              ),
              autocorrect: false,
              validator: controller.validatePrice,
              onSaved: controller.savePrice,
            ),
            TextFormField(
              initialValue: '${carCopy.makeYear}',
              decoration: InputDecoration(
                labelText: 'Make year',
              ),
              autocorrect: false,
              validator: controller.validateMakeyear,
              onSaved: controller.saveMakeyear,
            ),
            TextFormField(
              initialValue: carCopy.brand,
              decoration: InputDecoration(
                labelText: 'Car Brand',
              ),
              autocorrect: false,
              validator: controller.validateBrand,
              onSaved: controller.saveBrand,
            ),
            TextFormField(
              //maxLines: 5,
              decoration: InputDecoration(
                labelText: 'color'
              ),
              autocorrect: false,
              initialValue: carCopy.color,
              validator: controller.validateColor,
              onSaved: controller.saveColor,
            ),
            Text('CreateBy: '+ carCopy.createdBy),
            Text('Last Updated At: '+ carCopy.lastUpdatedAt.toString()),
            Text('DocumentID: '+ carCopy.documentId.toString()),
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